## Introduction
[OpenAI](https://openai.com/) is an AI research and deployment company. **Xojo-OpenAI** is a Xojo and RealStudio wrapper for the OpenAI public API.

## Example
This example asks the AI to correct a sentence for English spelling and grammar [**More examples**](https://github.com/charonn0/Xojo-OpenAI/wiki#examples).
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
* Modify, analyze, and parse text or source code according to instructions
* Analyze text for hate, threats, self-harm, sexual content, child abuse, and violence
* Can use the [RB-libcURL](https://github.com/charonn0/RB-libcURL) wrapper, the [MonkeyBread curl plugin](https://www.monkeybreadsoftware.net/class-curlmbs.shtml), or the Xojo URLConnection to make API requests. 

## Synopsis

### Caution: This project is still a work in progress and not everything works yet. 

OpenAI API endpoints are exposed through several object classes:

|Endpoint|Object Class|Comment|
|-----------|------------|-------|
|[`/v1/completions`](https://beta.openai.com/docs/api-reference/completions) and [`/v1/edits`](https://beta.openai.com/docs/api-reference/edits)|[`Completion`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion)|A text or code completion or edit.| 
|[`/v1/moderations`](https://beta.openai.com/docs/api-reference/moderations)|[`Moderation`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Moderation)|An analysis of offensive content in a given text. (i.e. "content moderation")| 
|[`/v1/images/generations`](https://beta.openai.com/docs/api-reference/images/create) and [`/v1/images/edits`](https://beta.openai.com/docs/api-reference/images/create-edit)|[`Image`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image)|An image that was generated or modified.| 
|[`/v1/models`](https://beta.openai.com/docs/api-reference/models)|[`Model`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model)|List and select from the available AI models|
|[`/v1/fine-tunes`](https://beta.openai.com/docs/api-reference/fine-tunes)|[`FineTune`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTune)|A base `Model` that has been, is being, or will be fine-tuned using a previously uploaded `File`.| 
|[`/v1/files`](https://beta.openai.com/docs/api-reference/files)|[`File`](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File)|A fine-tuning file that was or will be uploaded.| 

To make a request of the API, call the appropriate factory method on the corresponding object class. For example, to make a request of the `/v1/completions` endpoint you would use the [OpenAI.Completion.Create](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion.Create) or [OpenAI.Completion.Edit](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion.Edit) factory methods. Factory methods perform the request and return a [OpenAI.Response](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response) object (or one of its subclasses) containing the response.

Responses may have zero, one, or several choices, depending on the number of results you asked for. You can see how many choices are available by reading the [Response.ResultCount](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.ResultCount) property, and retrieve each result by calling the [Response.GetResult](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult) method.

Factory methods generally come in two flavors: basic and advanced. The basic versions accept a few common parameters as direct arguments while the advanced versions accept a [OpenAI.Request](https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request) object with the correct properties set. 

```realbasic
  OpenAI.APIKey = "YOUR API KEY"
  Dim request As New OpenAI.Request
  request.Model = OpenAI.Model.Lookup("text-davinci-003")
  request.MaxTokens = 60
  request.Prompt = "What is the airspeed velocity of an unladen European swallow?"
  Dim result As OpenAI.Response = OpenAI.Completion.Create(request)
  Dim choices() As String
  For i As Integer = 0 To result.ResultCount - 1
    choices.Append(result.GetResult(i))
  Next
```

## How to incorporate OpenAI into your Xojo project

### Import the OpenAI module
1. Download the Xojo-OpenAI project either in [ZIP archive format](https://github.com/charonn0/Xojo-OpenAI/archive/master.zip) or by cloning the repository with your Git client.
2. Open the Xojo-OpenAI project in REALstudio or Xojo. Open your project in a separate window.
3. Copy the Xojo-OpenAI module into your project and save. Do not use the "Import" feature.

### Using RB-libcURL or MBS
The OpenAI module may optionally use my open source [RB-libcURL](https://github.com/charonn0/RB-libcURL) wrapper or the commercial MBS libcurl plugin. These should be preferred in order to take advantage of HTTP/2. If neither of these are available, the built-in `URLConnection` class is used if it is available. In versions of Xojo/RealStudio that do not have the URLConnection class (<=2018r2) you will need to use one of the curl options.

To enable RB-libcURL, copy (not not Import) the `libcURL` module from the RB-libcURL project into your project and set the `OpenAI.USE_RBLIBCURL` constant to `True`.

To enable the MBS plugin, ensure the plugin is installed and then set `OpenAI.USE_MBS` constant to `True`.

If both `USE_RBLIBCURL` and `USE_MBS` are `True` then `USE_RBLIBCURL` takes precedence.

If you are using neither RB-libcURL nor MBS then set both `USE_RBLIBCURL` and `USE_MBS` to `False` to avoid compiler errors.

## Examples
* [Correct natural language](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#correct-text)
* [Translate natural language](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#translate-text)
* [Explain source code](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#explain-source-code)
* [Detect offensive content](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#check-text-for-offensive-content)
* [Generate picture](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#generate-picture)
* [Edit picture](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#edit-a-picture)
* [Sending custom requests](https://github.com/charonn0/Xojo-OpenAI/wiki/Examples#sending-a-custom-request)
