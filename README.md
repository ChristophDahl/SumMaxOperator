# Sum-/Max-Operator

As part of the class Visual Cognition (code: 3550E022) at Taipei Medical University, the sum- and max-operators have been discusses, as suggested by Riesenhuber and Poggio, 1999.
In their 1999 paper titled "Hierarchical Models of Object Recognition in Cortex," Riesenhuber and Poggio proposed a hierarchical model of object recognition in the visual cortex. They introduced the concept of a "sum and max" operation in the context of their model. The "sum and max" operation refers to how their model combines information from different levels or layers of processing within the neural network. In their model, information from lower-level neurons, which represent simple features like edges and orientations, is combined in two ways:

# Summation (Sum): 
The model performs a weighted summation of the responses from neurons at a particular layer. This means that it combines the outputs of neurons by adding them up after applying certain weights to them.

# Maximum (Max): 
The model also takes the maximum response among a group of neurons at a particular layer. This means that it considers the most strongly activated neuron's response as the dominant feature at that level.

By using both summation and maximum operations, Riesenhuber and Poggio's model aimed to capture different aspects of object recognition. The summation operation allows for the integration of information from multiple neurons, helping to detect various features within an object. On the other hand, the maximum operation emphasizes the most salient or important feature within the object.

In the following, you find an implementation in Matlab for the Sum- and Max-operators.
As a result, an input image should lead to a distinct featural representation using the sum operator, but an identical representation across variation in features (here the position of a line in the receptive field) using the max operator.


![Diagonal_filtersize10_dimension14_line_intensity0_background_intensity255](https://github.com/ChristophDahl/SumMaxOperator/assets/56686743/6cc28b39-5155-4023-aae7-691d068110bc)
![Diagonal_filtersize10_dimension14_line_intensity255_background_intensity0](https://github.com/ChristophDahl/SumMaxOperator/assets/56686743/eacdee88-5dbe-41cb-b1db-b197eeef729c)
![Left_filtersize10_dimension14_line_intensity0_background_intensity255](https://github.com/ChristophDahl/SumMaxOperator/assets/56686743/b8b01f9b-82d3-4173-913f-cc3c871adc49)
![Left_filtersize10_dimension14_line_intensity255_background_intensity0](https://github.com/ChristophDahl/SumMaxOperator/assets/56686743/e3fc316b-ca62-427a-b904-7253bd76b62b)
![Right_filtersize10_dimension14_line_intensity0_background_intensity255](https://github.com/ChristophDahl/SumMaxOperator/assets/56686743/3f6bc0f7-cd63-491d-ba78-a8c4a635a2b3)
![Right_filtersize10_dimension14_line_intensity255_background_intensity0](https://github.com/ChristophDahl/SumMaxOperator/assets/56686743/9644ccc2-0f54-4d41-ad40-80a90d5d0a2e)
