# NFTs IDs - Manipulacion de bits
Contrato ERC721, con los IDs de los NFTs conteniendo información a nivel de bits.

Cuando se paga por el almacenamiento de datos, **el tamaño sí importa**. Los números enteros de un Smart Contract ocupan 256 bits de espacio, con independencia de si se usan todos los bits o no. Sin embargo, normalmente los ids de los NFTs utilizan una cantidad ridicula de este espacio y no nos aportan mayor información. 

Por esta razón, existe una practica muy chula que consiste en subdividir este caja de 256 bits en cajas más pequeños y en cada una guardar un dato diferente. Pensarlo como si fuese un conjunto de piezas de LEGO que todas agregadas ocupan 256 bits. En un subcaja se puede guardar una fecha, en otra un precio, etc.. Sin necesidad de crear mapeos adicionales en solidity para vincular estas informaciones, con el consiguiente ahorro de gas. 

Para realizar esta practica es necesario la manipulación del ID del NFT a nivel de bits con los operadores >> y <<. En este ejemplo, incorporo los siguientes datos para un supuesto hotel: 

	 Referencia de la compra de la habitación.
	 Precio pagado.
	 Fecha de finalización (Salida de la habitación)
	 Fecha de entrada (Entrada para el uso de la habitación)

El ID del token ya tiene toda la información si se presenta en el hotel para ser consumido, O incluso se podría revender.
