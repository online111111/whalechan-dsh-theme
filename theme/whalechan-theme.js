(() => {
  const KEY = 'dsh.whalechan.theme.enabled';
  const root = document.documentElement;
  const asset = '/whalechan/whalechan-riding-whale-64.png';

  function enabled() {
    try { return localStorage.getItem(KEY) !== 'off'; } catch { return true; }
  }

  function apply(on) {
    root.dataset.whalechanTheme = on ? 'on' : 'off';
    try { localStorage.setItem(KEY, on ? 'on' : 'off'); } catch {}
    const button = document.getElementById('whalechan-theme-toggle');
    if (button) {
      button.setAttribute('aria-pressed', String(on));
      button.title = on ? '关闭 Whale-chan 实验主题' : '开启 Whale-chan 实验主题';
      const label = button.querySelector('[data-whale-label]');
      if (label) label.textContent = on ? '鲸鱼娘主题：已开启' : '鲸鱼娘主题：已关闭';
    }
  }

  function mountToggle() {
    if (document.getElementById('whalechan-theme-toggle')) return;
    const button = document.createElement('button');
    button.id = 'whalechan-theme-toggle';
    button.type = 'button';
    button.innerHTML = `<img class="whalechan-toggle-icon" src="${asset}" alt=""><span data-whale-label></span>`;
    button.addEventListener('click', () => apply(root.dataset.whalechanTheme !== 'on'));
    document.body.appendChild(button);
    apply(enabled());
  }

  function tagDynamicElements() {
    // 1. Tag permission trigger button
    const trigger = document.querySelector('button.Sh0Q9G_trigger');
    if (trigger) {
      const txt = trigger.innerText.trim();
      if (txt.includes('Read Only') || txt.includes('只读')) trigger.dataset.permissionMode = 'read-only';
      else if (txt.includes('Workspace Write') || txt.includes('工作区写入')) trigger.dataset.permissionMode = 'workspace-write';
      else if (txt.includes('Full access') || txt.includes('完全访问')) trigger.dataset.permissionMode = 'danger-full-access';
    }

    // 2. Tag permission dropdown menu items
    document.querySelectorAll('[role="menuitem"]').forEach(item => {
      const txt = item.innerText.trim();
      if (txt.includes('Read Only')) item.dataset.permissionOption = 'read-only';
      else if (txt.includes('Workspace Write')) item.dataset.permissionOption = 'workspace-write';
      else if (txt.includes('Full access')) item.dataset.permissionOption = 'danger-full-access';
    });
  }

  const observer = new MutationObserver(tagDynamicElements);
  observer.observe(document.documentElement, { childList: true, subtree: true });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
      mountToggle();
      tagDynamicElements();
    }, { once: true });
  } else {
    mountToggle();
    tagDynamicElements();
  }
})();
