// Lucide Icons CDN Fallback
(function() {
    // Если lucide уже загружен, ничего не делаем
    if (window.lucide) return;
    
    // Создаем пустой объект для предотвращения ошибок
    window.lucide = {
        createIcons: function(options) {
            // Пытаемся загрузить с CDN
            if (!document.getElementById('lucide-cdn')) {
                const script = document.createElement('script');
                script.id = 'lucide-cdn';
                script.src = 'https://cdn.jsdelivr.net/npm/lucide@latest/dist/umd/lucide.js';
                script.onload = function() {
                    // После загрузки CDN версии, инициализируем иконки
                    if (window.lucide && window.lucide.createIcons) {
                        window.lucide.createIcons(options);
                    }
                };
                script.onerror = function() {
                    console.warn('Не удалось загрузить Lucide icons с CDN');
                };
                document.head.appendChild(script);
            }
        }
    };
})(); 