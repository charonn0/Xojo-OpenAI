## Introduction
[OpenAI](https://openai.com/) is an AI research and deployment company. **Xojo-OpenAI** is Xojo and RealStudio wrapper for the OpenAI public API.

## Example
This example asks the AI to correct a sentence for English spelling and grammar [**More examples**](https://github.com/charonn0/RB-libcURL/wiki#examples).
```realbasic
  OpenAI.APIKey = "YOUR API KEY"
  Dim instruction As String = "Correct this to standard English" ' natural language instructions to AI
  Dim prompt As String = "This ez uh test uv teh OpenAI AIP"
  Dim result As OpenAI.Response = OpenAI.Completion.Edit(prompt, instruction)
  Dim correction As String = result.GetResult(0)
```

## Highlights
* Issue natural-language instructions to the AI
* Generate images based on a description
* Modify, analyse, and partse text or source code according to instructions

## Synopsis

OpenAI API endpoints are exposed through several object classes:

|Endpoint|Object Class|Comment|
|-----------|------------|-------|
|[`/v1/models`](https://beta.openai.com/docs/api-reference/models)|[`Model`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model)|List the AI models that are available.| 
|[`/v1/completions`](https://beta.openai.com/docs/api-reference/completions) and [`/v1/edits`](https://beta.openai.com/docs/api-reference/edits)|[`Completion`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion)|A text or code completion or edit.| 
|[`/images/generations`](https://beta.openai.com/docs/api-reference/images/create) and [`/v1/images/edits`](https://beta.openai.com/docs/api-reference/images/create-edit)|[`Image`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image)|An image that was generated or modified.| 
|[`/v1/files`](https://beta.openai.com/docs/api-reference/files)|[`File`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image)|A file that was or will be uploaded.| 
|[`/v1/fine-tunes`](https://beta.openai.com/docs/api-reference/fine-tunes)|[`FineTune`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTune)|TBD.| 
|[`/v1/moderations`](https://beta.openai.com/docs/api-reference/moderations)|[`Moderation`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Moderation)|TBD.| 

### Import the OpenAI module
1. Download the Xojo-OpenAI project either in [ZIP archive format](https://github.com/charonn0/Xojo-OpenAI/archive/master.zip) or by cloning the repository with your Git client.
2. Open the Xojo-OpenAI project in REALstudio or Xojo. Open your project in a separate window.
3. Copy the Xojo-OpenAI module into your project and save.

### Using libcURL or CURLMBS 
The OpenAI module may be used with either [RB-libcURL](https://github.com/charonn0/RB-libcURL) or [CURLMBS](https://www.monkeybreadsoftware.net/class-curlmbs.shtml). If neither of these are available, the built-in `URLConnection` class is used if it is available.

To enable RB-libcURL, import the libcURL module and set `OpenAI.USE_RBLIBCURL` to `True`.

To enable CURLMBS, ensure the MBS IDE plugin is installed and then set `OpenAI.USE_MBS` to `True`.

If both `USE_RBLIBCURL` and `USE_MBS` are `True` then `USE_RBLIBCURL` takes precedence.

## Examples
* [Correct natural language](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples/translate-text)
* [Translate natural language](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples/translate-text)
* [Explain source code](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples/explain-source-code)
* [Generate picture](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples/generate-picture)
