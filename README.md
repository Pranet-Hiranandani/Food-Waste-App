# Perishably
<img src="https://user-images.githubusercontent.com/83014418/159121420-d75f4466-1b0d-48c5-b778-eb0e3a7db8b9.png" width="300">

An intuitive and innovative app that predicts the expiry of your fruits and helps you locate nearby food donation centers. 

## Problem Statement

In India, 23 million tonnes of food cereals, 12 million tonnes of fruits, and 21 million tonnes of vegetables are lost each year, with a total estimated value of 240 billion Rupees. A recent estimate by the Ministry of Food Processing is that agricultural produce worth 580 billion Rupees is wasted in India each year! Due to the lack of knowing whether they can donate food and knowledge of donation centers, people end up throwing their leftover food. 

## Solution

- An AI based app that predicts the expiry of fruits
- The user can manage his/her food better, thus reducing wastage
- The user has an option to locate nearby donation centers, to donate leftover food

## Dataset

To accurately predict an expiry date, I decided to use two layers. One for predicting whether the fruit is ripe, unripe or expired. The second for classifying the fruit, thus to be able to use a rule based algorithm to predict an approximate expiry date. 

### Layer 1

- Total of 600 images
- Comprising of 3 classes- Ripe, Unripe and Expired
- Collected from Google Images for five different fruits- Apples, Bananas, Mangos, Peaches, Pears
- 540 images for training, 60 images for validation

### Layer 2

- Total of 4,653 images
- Comprising of 5 classes- Apples, Bananas, Mangos, Peaches, Pears
- Extracted from [Fruits 262](https://www.kaggle.com/datasets/aelchimminut/fruits262) dataset
- 4188 images for training, 465 images for validation

## Machine Learning Model

- Used MobileNetv2 CNN algorithm
- Eperimented with ResNet50 algorithm

### Layer 1

- Accuracy - 91%

![accuracylayer1](https://user-images.githubusercontent.com/83014418/159122116-fb7d543c-7e50-44d3-a947-911c91a08a0f.png)

- Loss - 0.16

![losslayer1](https://user-images.githubusercontent.com/83014418/159122122-ea905083-37aa-431b-b91a-ab40e3d1a390.png)

### Layer 2

- Accuracy - 87%

![accuracylayer2](https://user-images.githubusercontent.com/83014418/159122190-490ff95f-585d-4575-b169-067fce1f88aa.png)

- Loss - 0.28

![losslayer2](https://user-images.githubusercontent.com/83014418/159122199-0becdeb6-9fb1-46ec-bc58-f8764eaf7c1c.png)

## App Development

- Built the app using Flutter, a multiplatform mobile app framework
- Used Tensorflow Lite for machine learning on mobile

## Future Plans
- Further improve the accuracy of the model
- Improve the accuracy of expiry prediction- transition from rule-based to machine learning approach
- Make the app publicly available
- Collaborate with food donation centers and organisations to form a Perishably community
