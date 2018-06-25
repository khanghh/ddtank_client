package gemstone.items
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import gemstone.GemstoneManager;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstoneTipVO;
   
   public class GemstoneContent extends Component
   {
      
      public static var _radius:int = 100;
       
      
      public var angle:int;
      
      public var curExp:int;
      
      public var curTotalExp:int;
      
      public var level:int;
      
      public var info:GemstListInfo;
      
      private var _setupAngle:int = 120;
      
      private var _initAngle:int = 30;
      
      private var _bgBlue:MovieClip;
      
      private var _bgGolden:MovieClip;
      
      private var _upgradeLight:MovieClip;
      
      private var _content:Bitmap;
      
      private var _upGradeMc:MovieClip;
      
      private var txt:FilterFrameText;
      
      private var _onChangeBG:Function;
      
      public function GemstoneContent($i:int, $p:Point)
      {
         super();
         x = Math.round($p.x + Math.cos((_setupAngle * $i + _initAngle) / 180 * 3.14159265358979) * _radius);
         y = Math.round($p.y - Math.sin((_setupAngle * $i + _initAngle) / 180 * 3.14159265358979) * _radius);
         angle = _setupAngle * $i + _initAngle;
         _bgBlue = ComponentFactory.Instance.creat("gemstone.stoneContent.Blue");
         _bgBlue.x = -_bgBlue.width / 2;
         _bgBlue.y = -_bgBlue.height / 2;
         _bgGolden = ComponentFactory.Instance.creat("gemstone.stoneContent.Golden");
         _bgGolden.x = _bgBlue.x;
         _bgGolden.y = _bgBlue.y;
         _upgradeLight = ComponentFactory.Instance.creat("gemstone.upgradeLight");
         _upgradeLight.stop();
         _upgradeLight.mouseEnabled = false;
         _upgradeLight.x = _bgBlue.x;
         _upgradeLight.y = _bgBlue.y;
         txt = ComponentFactory.Instance.creatComponentByStylename("gemstoneTxt");
         txt.x = -61;
         txt.y = -21;
         tipStyle = "gemstone.items.GemstoneLeftViewTip";
         tipDirctions = "2,7";
      }
      
      public function changeBG(callBack:Function) : void
      {
         callBack = callBack;
         changeColor = function():void
         {
            _bgBlue.parent && removeChild(_bgBlue);
            addChildAt(_bgGolden,0);
         };
         upLightStart = function():void
         {
            addChild(_upgradeLight);
            _upgradeLight.gotoAndPlay(1);
         };
         upLightComplete = function():void
         {
            _upgradeLight.stop();
            removeChild(_upgradeLight);
            if(_onChangeBG != null)
            {
               _onChangeBG();
            }
         };
         _onChangeBG = callBack;
         var lightTotalFrames:int = _upgradeLight.totalFrames;
         TweenMax.delayedCall(0.5,changeColor);
         TweenMax.to(_upgradeLight,1,{
            "frame":lightTotalFrames,
            "onStart":upLightStart,
            "onComplete":upLightComplete
         });
      }
      
      public function setBG() : void
      {
         if(!info)
         {
            return;
         }
         if(!(int(info.level) - 6))
         {
            _bgBlue.parent && removeChild(_bgBlue);
            addChildAt(_bgGolden,0);
         }
         else
         {
            _bgGolden.parent && removeChild(_bgGolden);
            addChildAt(_bgBlue,0);
         }
      }
      
      public function loadSikn(str:String) : void
      {
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
         _content = ComponentFactory.Instance.creatBitmap(str);
         _content.smoothing = true;
         _content.x = -78;
         _content.y = -79;
         var _loc2_:* = 0.8;
         _content.scaleY = _loc2_;
         _content.scaleX = _loc2_;
         addChild(_content);
         addChild(txt);
      }
      
      public function upDataLevel() : void
      {
         txt.text = "LV" + info.level;
         updataTip();
      }
      
      public function updataTip() : void
      {
         var tempData:GemstoneTipVO = new GemstoneTipVO();
         tempData.level = info.level;
         var nextLevel:int = info.level < 6?info.level + 1:0;
         switch(int(info.fightSpiritId) - 100001)
         {
            case 0:
               tempData.gemstoneType = 1;
               tempData.increase = GemstoneManager.Instance.redInfoList[info.level].attack;
               tempData.nextIncrease = GemstoneManager.Instance.redInfoList[nextLevel].attack;
               break;
            case 1:
               tempData.gemstoneType = 2;
               tempData.increase = GemstoneManager.Instance.bluInfoList[info.level].defence;
               tempData.nextIncrease = GemstoneManager.Instance.bluInfoList[nextLevel].defence;
               break;
            case 2:
               tempData.gemstoneType = 3;
               tempData.increase = GemstoneManager.Instance.greInfoList[info.level].agility;
               tempData.nextIncrease = GemstoneManager.Instance.greInfoList[nextLevel].agility;
               break;
            case 3:
               tempData.gemstoneType = 4;
               tempData.increase = GemstoneManager.Instance.yelInfoList[info.level].luck;
               tempData.nextIncrease = GemstoneManager.Instance.yelInfoList[nextLevel].luck;
               break;
            case 4:
               tempData.gemstoneType = 5;
               tempData.increase = GemstoneManager.Instance.purpleInfoList[info.level].blood;
               tempData.nextIncrease = GemstoneManager.Instance.purpleInfoList[nextLevel].blood;
         }
         tipData = tempData;
      }
      
      public function selAlphe(i:Number) : void
      {
         _content.alpha = i;
      }
      
      override public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
