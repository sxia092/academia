#!/usr/bin/env python3
"""
Linear Algebra Library Visualizer
Demonstrates the actual algorithms from CS5201:
1. Gaussian Elimination with partial pivoting
2. Steepest Descent iterative solver
3. Matrix-Vector multiplication (Ax)
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation, PillowWriter
from matplotlib.gridspec import GridSpec
from matplotlib.patches import Rectangle, FancyArrowPatch
import matplotlib.patches as mpatches

# Style
plt.style.use('dark_background')
COLORS = {
    'bg': '#0d1117',
    'cell': '#161b22',
    'cell_highlight': '#1f6feb',
    'cell_pivot': '#f0883e',
    'cell_zero': '#238636',
    'text': '#c9d1d9',
    'text_dim': '#6e7681',
    'primary': '#58a6ff',
    'secondary': '#f78166',
    'tertiary': '#7ee787',
    'quaternary': '#d2a8ff',
    'grid': '#30363d',
    'contour': '#1f6feb'
}


class LinearAlgebraVisualizer:
    def __init__(self):
        self.fig = plt.figure(figsize=(18, 6), facecolor=COLORS['bg'])
        self.gs = GridSpec(1, 3, figure=self.fig, wspace=0.25,
                          left=0.03, right=0.97, top=0.88, bottom=0.08)

        self.ax1 = self.fig.add_subplot(self.gs[0, 0])
        self.ax2 = self.fig.add_subplot(self.gs[0, 1])
        self.ax3 = self.fig.add_subplot(self.gs[0, 2])

        self.frame_count = 180
        self.artists = []

        # Gaussian elimination data
        self.A_orig = np.array([[2., 1., 1.],
                                [4., 3., 3.],
                                [2., 1., 2.]], dtype=float)
        self.b_orig = np.array([8., 18., 10.], dtype=float)
        self.solution = np.array([1., 2., 2.])

        # Steepest descent data (2D for visualization)
        self.A_sd = np.array([[4., 1.], [1., 3.]], dtype=float)
        self.b_sd = np.array([1., 2.], dtype=float)
        self.x_sd_solution = np.linalg.solve(self.A_sd, self.b_sd)

        self.setup_axes()

    def setup_axes(self):
        for ax in [self.ax1, self.ax2, self.ax3]:
            ax.set_facecolor(COLORS['bg'])
            for spine in ax.spines.values():
                spine.set_visible(False)

        # Panel 1: Gaussian Elimination
        self.ax1.set_xlim(-0.5, 6)
        self.ax1.set_ylim(-1, 4.5)
        self.ax1.set_aspect('equal')
        self.ax1.axis('off')
        self.ax1.set_title('Gaussian Elimination', color=COLORS['text'],
                          fontsize=13, fontweight='bold', pad=10)

        # Panel 2: Steepest Descent
        self.ax2.set_xlim(-0.5, 1.5)
        self.ax2.set_ylim(-0.5, 1.5)
        self.ax2.set_aspect('equal')
        self.ax2.set_title('Steepest Descent', color=COLORS['text'],
                          fontsize=13, fontweight='bold', pad=10)
        self.ax2.tick_params(colors=COLORS['text_dim'], labelsize=8)

        # Panel 3: Matrix-Vector Product
        self.ax3.set_xlim(-0.5, 7)
        self.ax3.set_ylim(-0.5, 4)
        self.ax3.set_aspect('equal')
        self.ax3.axis('off')
        self.ax3.set_title('Matrix-Vector Product', color=COLORS['text'],
                          fontsize=13, fontweight='bold', pad=10)

    def draw_matrix_cell(self, ax, x, y, value, color=COLORS['cell'],
                        text_color=COLORS['text'], highlight=False, size=0.7):
        """Draw a single matrix cell"""
        artists = []
        edge_color = COLORS['primary'] if highlight else COLORS['grid']
        lw = 2 if highlight else 1

        rect = Rectangle((x, y), size, size, facecolor=color,
                         edgecolor=edge_color, linewidth=lw)
        ax.add_patch(rect)
        artists.append(rect)

        # Format value
        if abs(value) < 0.001:
            val_str = "0"
        elif abs(value - round(value)) < 0.001:
            val_str = f"{int(round(value))}"
        else:
            val_str = f"{value:.1f}"

        txt = ax.text(x + size/2, y + size/2, val_str, ha='center', va='center',
                     color=text_color, fontsize=10, fontweight='bold')
        artists.append(txt)
        return artists

    def draw_augmented_matrix(self, ax, A, b, x_offset=0, y_offset=3,
                             pivot_row=None, pivot_col=None,
                             zero_cells=None, phase=""):
        """Draw augmented matrix [A|b]"""
        artists = []
        n = A.shape[0]
        size = 0.7

        # Draw A matrix
        for i in range(n):
            for j in range(n):
                x = x_offset + j * size
                y = y_offset - i * size

                # Determine cell color
                color = COLORS['cell']
                highlight = False

                if pivot_row is not None and pivot_col is not None:
                    if i == pivot_row and j == pivot_col:
                        color = COLORS['cell_pivot']
                        highlight = True

                if zero_cells and (i, j) in zero_cells:
                    color = COLORS['cell_zero']

                artists.extend(self.draw_matrix_cell(ax, x, y, A[i, j],
                                                    color=color, highlight=highlight, size=size))

        # Separator line
        sep_x = x_offset + n * size + 0.05
        line = ax.plot([sep_x, sep_x], [y_offset - n * size + size, y_offset + size],
                      color=COLORS['text_dim'], linewidth=2, linestyle='--')[0]
        artists.append(line)

        # Draw b vector
        for i in range(n):
            x = x_offset + n * size + 0.15
            y = y_offset - i * size
            artists.extend(self.draw_matrix_cell(ax, x, y, b[i],
                                                color=COLORS['cell'], size=size))

        # Phase label
        if phase:
            txt = ax.text(x_offset + 1.5, y_offset + 1, phase,
                         ha='center', va='bottom', color=COLORS['quaternary'],
                         fontsize=9, style='italic')
            artists.append(txt)

        return artists

    def gaussian_elimination_steps(self):
        """Generate all steps of Gaussian elimination"""
        A = self.A_orig.copy()
        b = self.b_orig.copy()
        n = A.shape[0]
        steps = []

        # Initial state
        steps.append(('initial', A.copy(), b.copy(), None, None, set()))

        for col in range(n):
            # Find pivot
            max_row = col
            for i in range(col + 1, n):
                if abs(A[i, col]) > abs(A[max_row, col]):
                    max_row = i

            steps.append(('pivot', A.copy(), b.copy(), max_row, col, set()))

            # Swap if needed
            if max_row != col:
                A[[col, max_row]] = A[[max_row, col]]
                b[[col, max_row]] = b[[max_row, col]]
                steps.append(('swap', A.copy(), b.copy(), col, col, set()))

            # Eliminate
            zeros = set()
            for i in range(col + 1, n):
                if A[col, col] != 0:
                    factor = A[i, col] / A[col, col]
                    A[i, col:] -= factor * A[col, col:]
                    b[i] -= factor * b[col]
                    zeros.add((i, col))

            if zeros:
                steps.append(('eliminate', A.copy(), b.copy(), col, col, zeros))

        # Back substitution
        x = np.zeros(n)
        for i in range(n-1, -1, -1):
            x[i] = (b[i] - np.dot(A[i, i+1:], x[i+1:])) / A[i, i]
            steps.append(('backsub', A.copy(), b.copy(), i, i, set(), x.copy()))

        steps.append(('solution', A.copy(), b.copy(), None, None, set(), x.copy()))

        return steps

    def animate(self, frame):
        for artist in self.artists:
            try:
                artist.remove()
            except:
                pass
        self.artists = []

        phase = frame / self.frame_count

        # === PANEL 1: Gaussian Elimination ===
        self.animate_gaussian(phase)

        # === PANEL 2: Steepest Descent ===
        self.animate_steepest_descent(phase)

        # === PANEL 3: Matrix-Vector Product ===
        self.animate_matrix_vector(phase)

        return self.artists

    def animate_gaussian(self, phase):
        """Animate Gaussian elimination"""
        steps = self.gaussian_elimination_steps()
        n_steps = len(steps)

        # Map phase to step
        step_idx = min(int(phase * n_steps * 1.2), n_steps - 1)
        step = steps[step_idx]

        step_type = step[0]
        A, b = step[1], step[2]
        pivot_row = step[3] if len(step) > 3 else None
        pivot_col = step[4] if len(step) > 4 else None
        zeros = step[5] if len(step) > 5 else set()

        # Phase label
        phase_labels = {
            'initial': 'Original System',
            'pivot': 'Finding Pivot',
            'swap': 'Row Swap',
            'eliminate': 'Row Reduction',
            'backsub': 'Back Substitution',
            'solution': 'Solution Found!'
        }

        self.artists.extend(
            self.draw_augmented_matrix(self.ax1, A, b, x_offset=0.5, y_offset=3.2,
                                      pivot_row=pivot_row, pivot_col=pivot_col,
                                      zero_cells=zeros,
                                      phase=phase_labels.get(step_type, ''))
        )

        # Draw solution if available
        if len(step) > 6:
            x = step[6]
            txt = self.ax1.text(4.5, 2, 'x =', ha='center', va='center',
                               color=COLORS['text'], fontsize=12)
            self.artists.append(txt)

            for i, val in enumerate(x):
                self.artists.extend(
                    self.draw_matrix_cell(self.ax1, 5, 2.7 - i * 0.7, val,
                                         color=COLORS['cell_highlight'], size=0.7)
                )

        # Formula
        formula = self.ax1.text(2.5, -0.5, 'Ax = b  →  Row Echelon  →  Back Sub',
                               ha='center', va='top', color=COLORS['text_dim'],
                               fontsize=9)
        self.artists.append(formula)

    def animate_steepest_descent(self, phase):
        """Animate steepest descent solver"""
        A = self.A_sd
        b = self.b_sd
        x_sol = self.x_sd_solution

        # Create contour plot of ||Ax - b||²
        x_range = np.linspace(-0.3, 1.3, 100)
        y_range = np.linspace(-0.3, 1.3, 100)
        X, Y = np.meshgrid(x_range, y_range)

        # Compute error surface
        Z = np.zeros_like(X)
        for i in range(X.shape[0]):
            for j in range(X.shape[1]):
                x_test = np.array([X[i, j], Y[i, j]])
                residual = A @ x_test - b
                Z[i, j] = np.dot(residual, residual)

        # Draw contours
        levels = np.linspace(0, np.max(Z) * 0.8, 15)
        contour = self.ax2.contour(X, Y, Z, levels=levels, colors=COLORS['contour'],
                                   alpha=0.5, linewidths=0.8)
        for c in contour.collections:
            self.artists.append(c)

        # Animate descent path
        x0 = np.array([1.2, 1.0])  # Starting point
        path = [x0.copy()]
        x = x0.copy()

        # Steepest descent iterations
        for _ in range(20):
            r = b - A @ x
            Ar = A @ r
            alpha = np.dot(r, r) / np.dot(Ar, r)
            x = x + alpha * r
            path.append(x.copy())
            if np.linalg.norm(r) < 0.01:
                break

        path = np.array(path)

        # Draw path up to current phase
        n_points = max(1, int(phase * len(path)))
        if n_points > 1:
            line = self.ax2.plot(path[:n_points, 0], path[:n_points, 1],
                                color=COLORS['secondary'], linewidth=2,
                                marker='o', markersize=4, alpha=0.8)[0]
            self.artists.append(line)

        # Current point
        current_idx = min(n_points - 1, len(path) - 1)
        current = path[current_idx]
        point = self.ax2.scatter([current[0]], [current[1]],
                                color=COLORS['secondary'], s=80, zorder=5)
        self.artists.append(point)

        # Solution point
        sol_point = self.ax2.scatter([x_sol[0]], [x_sol[1]],
                                    color=COLORS['tertiary'], s=100,
                                    marker='*', zorder=6)
        self.artists.append(sol_point)

        # Residual display
        r_current = b - A @ current
        r_norm = np.linalg.norm(r_current)

        txt = self.ax2.text(0.5, -0.35, f'||r|| = {r_norm:.3f}',
                           ha='center', va='top', color=COLORS['secondary'],
                           fontsize=10, fontweight='bold')
        self.artists.append(txt)

        # Formula
        formula = self.ax2.text(0.5, 1.4, 'x ← x + αr,  α = (r·r)/(Ar·r)',
                               ha='center', va='bottom', color=COLORS['text_dim'],
                               fontsize=9)
        self.artists.append(formula)

    def animate_matrix_vector(self, phase):
        """Animate matrix-vector multiplication Ax"""
        A = np.array([[2., 1., 3.],
                      [1., 4., 2.],
                      [3., 2., 1.]])
        x = np.array([1., 2., 1.])
        result = A @ x

        size = 0.65
        cycle_time = 3  # Full cycle in phase units
        current_row = int((phase * cycle_time) % 3)

        # Draw A matrix
        txt = self.ax3.text(0.3, 3.3, 'A', ha='center', va='bottom',
                           color=COLORS['primary'], fontsize=11, fontweight='bold')
        self.artists.append(txt)

        for i in range(3):
            for j in range(3):
                highlight = (i == current_row)
                color = COLORS['cell_highlight'] if highlight else COLORS['cell']
                self.artists.extend(
                    self.draw_matrix_cell(self.ax3, j * size, 2.5 - i * size,
                                         A[i, j], color=color, size=size)
                )

        # Multiplication symbol
        txt = self.ax3.text(2.2, 1.8, '×', ha='center', va='center',
                           color=COLORS['text'], fontsize=16)
        self.artists.append(txt)

        # Draw x vector
        txt = self.ax3.text(2.9, 3.3, 'x', ha='center', va='bottom',
                           color=COLORS['secondary'], fontsize=11, fontweight='bold')
        self.artists.append(txt)

        for i in range(3):
            self.artists.extend(
                self.draw_matrix_cell(self.ax3, 2.6, 2.5 - i * size,
                                     x[i], color=COLORS['cell'], size=size)
            )

        # Equals sign
        txt = self.ax3.text(3.8, 1.8, '=', ha='center', va='center',
                           color=COLORS['text'], fontsize=16)
        self.artists.append(txt)

        # Draw result vector
        txt = self.ax3.text(4.6, 3.3, 'b', ha='center', va='bottom',
                           color=COLORS['tertiary'], fontsize=11, fontweight='bold')
        self.artists.append(txt)

        for i in range(3):
            # Show computed values up to current row
            if i <= current_row:
                color = COLORS['cell_highlight'] if i == current_row else COLORS['cell_zero']
                val = result[i]
            else:
                color = COLORS['cell']
                val = 0

            self.artists.extend(
                self.draw_matrix_cell(self.ax3, 4.2, 2.5 - i * size,
                                     val if i <= current_row else 0,
                                     color=color, size=size)
            )

        # Show dot product computation
        row = A[current_row]
        computation = f'({row[0]:.0f}×{x[0]:.0f}) + ({row[1]:.0f}×{x[1]:.0f}) + ({row[2]:.0f}×{x[2]:.0f}) = {result[current_row]:.0f}'
        txt = self.ax3.text(3.2, 0.3, computation, ha='center', va='top',
                           color=COLORS['quaternary'], fontsize=9,
                           fontfamily='monospace')
        self.artists.append(txt)

        # Formula
        formula = self.ax3.text(3.2, -0.2, 'b[i] = Σ A[i,k] × x[k]',
                               ha='center', va='top', color=COLORS['text_dim'],
                               fontsize=9)
        self.artists.append(formula)

    def generate_gif(self, output_path):
        """Generate the animation as GIF"""
        print(f"Generating {self.frame_count} frames...")

        anim = FuncAnimation(
            self.fig, self.animate,
            frames=self.frame_count,
            interval=50,
            blit=False
        )

        writer = PillowWriter(fps=20)
        anim.save(output_path, writer=writer, dpi=100)
        plt.close()
        print(f"Saved to {output_path}")


def main():
    viz = LinearAlgebraVisualizer()
    output_path = "linear_algebra.gif"
    viz.generate_gif(output_path)


if __name__ == "__main__":
    main()
