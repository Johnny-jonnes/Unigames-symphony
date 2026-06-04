const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
    // Ensure docs/images directory exists
    if (!fs.existsSync('docs/images')){
        fs.mkdirSync('docs/images', { recursive: true });
    }

    const browser = await puppeteer.launch({
        headless: 'new',
        defaultViewport: { width: 1280, height: 800 }
    });
    
    const page = await browser.newPage();
    const baseUrl = 'http://localhost:8000';

    console.log('Navigating to login page...');
    await page.goto(`${baseUrl}/login`);
    
    // Fill login form
    console.log('Logging in...');
    await page.type('#username', 'admin@unigames.com');
    await page.type('#password', 'password');
    await Promise.all([
        page.waitForNavigation(),
        page.click('button[type="submit"]')
    ]);

    const pagesToCapture = [
        { name: '01_dashboard', url: '/' },
        { name: '02_editions', url: '/editions/' },
        { name: '03_disciplines', url: '/disciplines/' },
        { name: '04_facultes', url: '/facultes/' },
        { name: '05_equipes', url: '/equipes/' },
        { name: '06_joueurs', url: '/joueurs/' },
        { name: '07_matchs', url: '/matchs/' },
        { name: '08_classements', url: '/classements/' }
    ];

    for (let p of pagesToCapture) {
        console.log(`Capturing ${p.name}...`);
        await page.goto(`${baseUrl}${p.url}`);
        // wait for a moment to ensure alpine/animations are loaded
        await new Promise(r => setTimeout(r, 1000));
        await page.screenshot({ path: `docs/images/${p.name}.png` });
    }

    console.log('Screenshots done!');
    await browser.close();
})();
