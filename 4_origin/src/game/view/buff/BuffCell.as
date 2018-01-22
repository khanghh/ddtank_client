package game.view.buff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.BuffType;
   import ddt.display.BitmapLoaderProxy;
   import ddt.display.BitmapObject;
   import ddt.display.BitmapSprite;
   import ddt.manager.BitmapManager;
   import ddt.manager.PathManager;
   import ddt.view.tips.PropTxtTipInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.view.buff.FightContainerBuff;
   
   public class BuffCell extends BitmapSprite implements ITipedDisplay
   {
       
      
      private var _info:FightBuffInfo;
      
      private var _bitmapMgr:BitmapManager;
      
      private var _tipData:PropTxtTipInfo;
      
      private var _txt:FilterFrameText;
      
      private var _loaderProxy:BitmapLoaderProxy;
      
      private var _buffAnimation:MovieClip;
      
      public function BuffCell(param1:BitmapObject = null, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false)
      {
         _tipData = new PropTxtTipInfo();
         super(param1,param2,false,true);
         _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
         _tipData = new PropTxtTipInfo();
         _tipData.color = 15790320;
         _txt = ComponentFactory.Instance.creatComponentByStylename("game.petskillBuff.numTxt");
         addChild(_txt);
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         if(_loaderProxy)
         {
            _loaderProxy.dispose();
         }
         _loaderProxy = null;
         _info = null;
         _tipData = null;
         _bitmapMgr.dispose();
         _bitmapMgr = null;
         _info = null;
         deleteBuffAnimation();
         super.dispose();
      }
      
      private function deleteBuffAnimation() : void
      {
         if(_buffAnimation)
         {
            this.removeChild(_buffAnimation);
            _buffAnimation = null;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function clearSelf() : void
      {
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_loaderProxy)
         {
            _loaderProxy.dispose();
         }
         _loaderProxy = null;
         bitmapObject = null;
         _info = null;
         deleteBuffAnimation();
      }
      
      public function setInfo(param1:FightBuffInfo) : void
      {
         if(_loaderProxy)
         {
            _loaderProxy.dispose();
         }
         _loaderProxy = null;
         bitmapObject = null;
         deleteBuffAnimation();
         _info = param1;
         _tipData.property = _info.buffName;
         _tipData.detail = _info.description;
         if(isContainerBuff(_info))
         {
            if(_info.type == 2)
            {
               bitmapObject = _bitmapMgr.getBitmap("asset.core.payBuffAsset");
            }
            else if(_info.type == 3)
            {
               bitmapObject = _bitmapMgr.getBitmap("asset.game.buffConsortia");
            }
            else
            {
               bitmapObject = _bitmapMgr.getBitmap("asset.game.buffCard");
            }
         }
         else if(param1.type == 5)
         {
            _loaderProxy = new BitmapLoaderProxy(PathManager.solvePetBuff(param1.buffPic),new Rectangle(0,0,32 / this.scaleX,32 / this.scaleY));
            addChild(_loaderProxy);
            ShowTipManager.Instance.addTip(this);
         }
         else if(param1.type == 6)
         {
            if(param1.showType == 1)
            {
               _loaderProxy = new BitmapLoaderProxy(PathManager.solvePetBuff(param1.buffPic),new Rectangle(0,0,32 / this.scaleX,32 / this.scaleY));
               addChild(_loaderProxy);
               ShowTipManager.Instance.addTip(this);
            }
            else
            {
               _loaderProxy = new BitmapLoaderProxy(PathManager.solvePetBuff(param1.buffPic),new Rectangle(0,0,20 / this.scaleX,20 / this.scaleY));
               addChild(_loaderProxy);
            }
         }
         else if(isActivityDunBuff(_info))
         {
            _buffAnimation = ComponentFactory.Instance.creat("asset.game.buff" + _info.displayid);
            addChild(_buffAnimation);
         }
         else
         {
            bitmapObject = _bitmapMgr.getBitmap("asset.game.buff" + _info.displayid);
         }
         if(_info.Count > 1 || _info.id == 1435 || _info.id == 1514)
         {
            addChild(_txt);
            _txt.text = _info.Count.toString();
         }
         else if(contains(_txt))
         {
            removeChild(_txt);
         }
         if(BuffType.isLocalBuffByID(_info.id) || isContainerBuff(_info))
         {
            ShowTipManager.Instance.addTip(this);
         }
      }
      
      public function get tipData() : Object
      {
         if(isContainerBuff(_info))
         {
            return FightContainerBuff(_info).tipData;
         }
         return _tipData;
      }
      
      private function isContainerBuff(param1:FightBuffInfo) : Boolean
      {
         return param1.type == 2 || param1.type == 3 || param1.type == 4;
      }
      
      private function isActivityDunBuff(param1:FightBuffInfo) : Boolean
      {
         return param1.displayid == 114 || param1.displayid == 115;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "7,6,5,1,6,4";
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 6;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 6;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         if(isContainerBuff(_info))
         {
            return "core.PayBuffTip";
         }
         return "core.FightBuffTip";
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
   }
}
