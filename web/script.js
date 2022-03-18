
async function classify() {
    let model;
    const modelURL = "assets/model.json";
    const metadataURL = "assets/metadata.json";
    model = await tmImage.load(modelURL, metadataURL);
    const prediction = await model.predict(webcam.canvas);
    for (let i = 0; i < maxPredictions; i++) {
        const classPrediction =
            prediction[i].className + ": " + prediction[i].probability.toFixed(2);
        window.alert(classPrediction);
    }
}
