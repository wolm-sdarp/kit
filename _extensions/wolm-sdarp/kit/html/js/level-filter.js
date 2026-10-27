// WoLM SDARP — фильтр разделов по уровням (Novice … Expert).
// Подписи кнопок берутся из CSS-переменных --wolm-lab-* (их задаёт фильтр wolm.lua
// из метаданных wolm.labs), поэтому скрипт не зависит от языка книги.
// Состояние хранится в sessionStorage (только на время сессии браузера).
document.addEventListener('DOMContentLoaded', () => {
  const LEVELS = ['lab-novice', 'lab-junior', 'lab-middle', 'lab-senior', 'lab-expert'];
  const STORAGE_KEY = 'wolmLevelFilter';

  const css = getComputedStyle(document.documentElement);
  const cssText = (name, fallback) => {
    const v = css.getPropertyValue(name).trim().replace(/^["']|["']$/g, '');
    return v || fallback;
  };

  // Разделы с лейблами есть на странице?
  const present = LEVELS.filter(cls => document.querySelector(`section.${cls}`));
  if (present.length === 0) return;

  let saved = {};
  try { saved = JSON.parse(sessionStorage.getItem(STORAGE_KEY) || '{}'); } catch (e) { saved = {}; }
  const active = {};

  const container = document.createElement('div');
  container.id = 'wolm-level-filter';
  container.setAttribute('role', 'group');
  container.setAttribute('aria-label', cssText('--wolm-level-filter-label', 'Filter sections by level'));

  const apply = (cls) => {
    document.querySelectorAll(`section.${cls}`).forEach(s => s.classList.toggle('wolm-hidden', !active[cls]));
  };

  for (const cls of present) {
    active[cls] = saved[cls] !== undefined ? saved[cls] : true;
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'wolm-level-btn';
    btn.dataset.level = cls;
    btn.textContent = cssText(`--wolm-${cls}`, cls.replace('lab-', ''));
    const sync = () => {
      btn.classList.toggle('active', active[cls]);
      btn.classList.toggle('inactive', !active[cls]);
      btn.setAttribute('aria-pressed', String(active[cls]));
    };
    btn.addEventListener('click', () => {
      active[cls] = !active[cls];
      sync();
      apply(cls);
      try { sessionStorage.setItem(STORAGE_KEY, JSON.stringify(active)); } catch (e) { /* storage недоступен */ }
    });
    sync();
    apply(cls);
    container.appendChild(btn);
  }

  // После заголовка страницы (или в начало main)
  const titleEl = document.querySelector('#title-block-header h1, header h1, h1.title');
  const mainEl = document.querySelector('main') || document.body;
  if (titleEl) { titleEl.insertAdjacentElement('afterend', container); } else { mainEl.prepend(container); }
});
