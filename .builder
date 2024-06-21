<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Builder File Loader</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 600px; margin: 50px auto; text-align: center; }
        input[type="file"] { margin-bottom: 20px; }
        pre { text-align: left; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Builder File Loader</h1>
        <input type="file" id="fileInput" accept=".builder">
        <pre id="output"></pre>
    </div>

    <script>
        document.getElementById('fileInput').addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const content = e.target.result;
                    const output = document.getElementById('output');
                    output.textContent = interpret(content);
                };
                reader.readAsText(file);
            }
        });

        function interpret(code) {
            const lines = code.split('\n');
            const variables = {};
            let output = '';

            function print(value) {
                output += value + '\n';
            }

            lines.forEach(line => {
                const trimmedLine = line.trim();
                if (trimmedLine.startsWith('var')) {
                    const [_, varName, varValue] = trimmedLine.match(/var\s+(\w+)\s*=\s*(.+)/);
                    variables[varName] = eval(varValue);
                } else if (trimmedLine.startsWith('print')) {
                    const value = trimmedLine.match(/print\((.+)\)/)[1];
                    print(eval(value));
                }
            });

            return output;
        }
    </script>
</body>
</html>
