const yargs = require('yargs/yargs')
const { hideBin } = require('yargs/helpers')
const argv = yargs(hideBin(process.argv)).argv

console.log(`Kafka service URL is ${argv.server}`);
console.log(`Topic is ${argv.topic}`);
console.log(`Message is ${argv.message}`);

try{

    var kafka = require('kafka-node'),
        HighLevelProducer = kafka.HighLevelProducer,
        client = new kafka.KafkaClient({kafkaHost: argv.server}),
        producer = new HighLevelProducer(client),
        payloads = [
            { topic: argv.topic, messages: argv.message }
        ];
    producer.on('ready', function () {
        producer.send(payloads, function (err, data) {
            console.log(data);
        });
    });
}
catch(err){
    console.log( `error ${err} occured while pushing ${argv.message} to topic -  ${argv.topic} `);
}