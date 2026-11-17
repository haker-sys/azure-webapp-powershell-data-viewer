
const http = require('http');
const fs = require('fs');
const path = require('path');

let receivedData = [];

const PORT = process.env.PORT || 8080;

const server = http.createServer((req, res) => {

    // CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        res.writeHead(204);
        return res.end();
    }

    // Serve frontend HTML
    if (req.method === 'GET' && req.url === '/') {

        const htmlPath = path.join(__dirname, 'index.html');

        fs.readFile(htmlPath, (err, content) => {

            if (err) {
                console.error('Could not find index.html:', err);

                res.writeHead(500);
                return res.end('Could not load index.html');
            }

            res.writeHead(200, {
                'Content-Type': 'text/html'
            });

            res.end(content);
        });

        return;
    }

    // Receive PowerShell data
    if (req.method === 'POST' && req.url === '/data') {

        let body = '';

        req.on('data', chunk => {
            body += chunk.toString();
        });

        req.on('end', () => {

            try {

                const data = JSON.parse(body);

                receivedData.push(data);

                console.log('Received:', data);

                res.writeHead(200, {
                    'Content-Type': 'application/json'
                });

                res.end(JSON.stringify({ success: true }));

            } catch (error) {

                res.writeHead(400);
                res.end('Invalid JSON');
            }
        });

        return;
    }

    // Send data to frontend
    if (req.method === 'GET' && req.url === '/data') {

        res.writeHead(200, {
            'Content-Type': 'application/json'
        });

        res.end(JSON.stringify(receivedData));

        return;
    }
	
	// Clear all received data
	if (req.method === 'POST' && req.url === '/clear') {

		receivedData = [];

		console.log('All data cleared');

		res.writeHead(200, {
			'Content-Type': 'application/json'
		});

		res.end(JSON.stringify({ success: true }));

		return;
	}

    // Unknown URL
    res.writeHead(404);
    res.end('Not Found');

});

server.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
});
