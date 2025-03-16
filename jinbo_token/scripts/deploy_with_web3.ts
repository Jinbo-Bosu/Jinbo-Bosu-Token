import { deploy } from './web3-lib';

(async () => {
  try {
    const result = await deploy('JinBoToken', []);
    console.log(`address: ${result.address}`);
  } catch (e) {
    console.log(e.message);
  }
})();
