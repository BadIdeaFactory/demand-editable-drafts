const Utils = {
  pixelsToPoints: (px) => {
    const pixelsPerInch = (96*window.devicePixelRatio);
    // fontSize is measured in pixels w/ a a 72dpi assumption
    return px * (72/pixelsPerInch);
  },
  pixelsToTWIPs: (px) =>{
    return Utils.pixelsToPoints(px) * 20;
  },
  closeEnough: (a, b) => { return (Math.abs(a - b) < 0.001); },
};

export default Utils;