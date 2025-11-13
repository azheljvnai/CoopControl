/**
 * Toast Notification System
 * Provides user feedback for actions (success, error, warning)
 */

// Create toast container if it doesn't exist
function initToastContainer() {
    if (!document.getElementById('toastContainer')) {
        const container = document.createElement('div');
        container.id = 'toastContainer';
        container.className = 'toast-container';
        document.body.appendChild(container);
    }
}

// Show toast notification
function showToast(type, title, message, duration = 3000) {
    initToastContainer();
    const container = document.getElementById('toastContainer');
    
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    
    // Icon mapping
    const icons = {
        success: '<i class="fas fa-check-circle toast-icon"></i>',
        error: '<i class="fas fa-exclamation-circle toast-icon"></i>',
        warning: '<i class="fas fa-exclamation-triangle toast-icon"></i>',
        info: '<i class="fas fa-info-circle toast-icon"></i>'
    };
    
    toast.innerHTML = `
        ${icons[type] || icons.info}
        <div class="toast-content">
            <div class="toast-title">${title}</div>
            ${message ? `<div class="toast-message">${message}</div>` : ''}
        </div>
        <button class="toast-close" onclick="this.parentElement.remove()">
            <i class="fas fa-times"></i>
        </button>
    `;
    
    container.appendChild(toast);
    
    // Auto-remove after duration
    if (duration > 0) {
        setTimeout(() => {
            toast.style.animation = 'slideOutRight 0.3s ease';
            setTimeout(() => toast.remove(), 300);
        }, duration);
    }
    
    // Prevent too many toasts (max 5)
    const toasts = container.querySelectorAll('.toast');
    if (toasts.length > 5) {
        toasts[0].remove();
    }
}

// Convenience functions
function showSuccess(title, message, duration) {
    showToast('success', title, message, duration);
}

function showError(title, message, duration) {
    showToast('error', title, message, duration);
}

function showWarning(title, message, duration) {
    showToast('warning', title, message, duration);
}

function showInfo(title, message, duration) {
    showToast('info', title, message, duration);
}

