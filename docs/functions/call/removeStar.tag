<docs-removeStar>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="url">
                <legend>URL</legend>
                <input onkeyup={updateText} type="text" value={specs.url} />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Call</button>
    <section ref="response" if={response} class="response">
        <h2>Response</h2>
        <pre class="prettyprint"><xmp ref="responseCode" class="code">{response}</xmp></pre>
    </section>
    <script>
        import {updateCallFunction} from '../../scripts/updateCode.js';
        import removeStar from '../../../lib/scripts/removeStar.js';

        this.input = '';
        this.response = '';
        this.specs = {
            "url": "http://docs.graphjs.com"
        }

        this.on('mount', function() {
            updateCallFunction(opts.function, this.specs, this.refs.inputCode);
        });

        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.handleCode = () => {
            updateCallFunction(opts.function, this.specs, this.refs.inputCode);
        }
        this.callback = (response) => {
            this.response = JSON.stringify(response, null, 4);
            this.update();
            this.refs.responseCode.parentNode.classList.remove('prettyprinted');
            PR.prettyPrint();
            this.refs.response.scrollIntoView();
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            let self = this;
            event.target.classList.add('loading');
            self.response = false;
            removeStar(
                self.specs.url,
                function(response) {
                    self.callback(response);
                    event.target.classList.remove('loading');
                }
            );
        }
    </script>
</docs-removeStar>