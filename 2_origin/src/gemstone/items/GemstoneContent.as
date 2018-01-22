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
      
      public function GemstoneContent(param1:int, param2:Point)
      {
         super();
         x = Math.round(param2.x + Math.cos((_setupAngle * param1 + _initAngle) / 180 * 3.14159265358979) * _radius);
         y = Math.round(param2.y - Math.sin((_setupAngle * param1 + _initAngle) / 180 * 3.14159265358979) * _radius);
         angle = _setupAngle * param1 + _initAngle;
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
      
      public function changeBG(param1:Function) : void
      {
         callBack = param1;
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
      
      public function loadSikn(param1:String) : void
      {
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
         _content = ComponentFactory.Instance.creatBitmap(param1);
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
         var _loc2_:GemstoneTipVO = new GemstoneTipVO();
         _loc2_.level = info.level;
         var _loc1_:int = info.level < 6?info.level + 1:0;
         switch(int(info.fightSpiritId) - 100001)
         {
            case 0:
               _loc2_.gemstoneType = 1;
               _loc2_.increase = GemstoneManager.Instance.redInfoList[info.level].attack;
               _loc2_.nextIncrease = GemstoneManager.Instance.redInfoList[_loc1_].attack;
               break;
            case 1:
               _loc2_.gemstoneType = 2;
               _loc2_.increase = GemstoneManager.Instance.bluInfoList[info.level].defence;
               _loc2_.nextIncrease = GemstoneManager.Instance.bluInfoList[_loc1_].defence;
               break;
            case 2:
               _loc2_.gemstoneType = 3;
               _loc2_.increase = GemstoneManager.Instance.greInfoList[info.level].agility;
               _loc2_.nextIncrease = GemstoneManager.Instance.greInfoList[_loc1_].agility;
               break;
            case 3:
               _loc2_.gemstoneType = 4;
               _loc2_.increase = GemstoneManager.Instance.yelInfoList[info.level].luck;
               _loc2_.nextIncrease = GemstoneManager.Instance.yelInfoList[_loc1_].luck;
               break;
            case 4:
               _loc2_.gemstoneType = 5;
               _loc2_.increase = GemstoneManager.Instance.purpleInfoList[info.level].blood;
               _loc2_.nextIncrease = GemstoneManager.Instance.purpleInfoList[_loc1_].blood;
         }
         tipData = _loc2_;
      }
      
      public function selAlphe(param1:Number) : void
      {
         _content.alpha = param1;
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
