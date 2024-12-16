// 音符顏色和樣式設定
const colors = ['#ff5f5f', '#faff50', '#50ffa1', '#509dff', '#b050ff']; // 明亮顏色
const notes = ['♪', '♫', '♬', '♩', '♭', '♮']; // 不同音符字符

// 音符生成函數
function createNote() {
    const container = document.getElementById('note-animation-container');

    // 創建音符元素
    const note = document.createElement('div');
    note.className = 'note';

    // 隨機分配音符字符和顏色
    note.textContent = notes[Math.floor(Math.random() * notes.length)];
    note.style.color = colors[Math.floor(Math.random() * colors.length)];

    // 隨機初始位置
    note.style.left = `${Math.random() * 90}%`;
    note.style.top = `${Math.random() * 50 + 50}%`;

    container.appendChild(note);

    // 點擊音符觸發特效
    note.addEventListener('click', () => {
        note.classList.add('clicked');
        setTimeout(() => note.remove(), 500); // 點擊後移除音符
    });

    // 動畫結束後移除元素
    note.addEventListener('animationend', () => note.remove());
}

// 每隔300毫秒生成一個音符
setInterval(createNote, 300);
