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
      
      public function BuffCell(bitmap:BitmapObject = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
      {
         _tipData = new PropTxtTipInfo();
         super(bitmap,matrix,false,true);
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
      
      public function setInfo(val:FightBuffInfo) : void
      {
         if(_loaderProxy)
         {
            _loaderProxy.dispose();
         }
         _loaderProxy = null;
         bitmapObject = null;
         deleteBuffAnimation();
         _info = val;
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
         else if(val.type == 5)
         {
            _loaderProxy = new BitmapLoaderProxy(PathManager.solvePetBuff(val.buffPic),new Rectangle(0,0,32 / this.scaleX,32 / this.scaleY));
            addChild(_loaderProxy);
            ShowTipManager.Instance.addTip(this);
         }
         else if(val.type == 6)
         {
            if(val.showType == 1)
            {
               _loaderProxy = new BitmapLoaderProxy(PathManager.solvePetBuff(val.buffPic),new Rectangle(0,0,32 / this.scaleX,32 / this.scaleY));
               addChild(_loaderProxy);
               ShowTipManager.Instance.addTip(this);
            }
            else
            {
               _loaderProxy = new BitmapLoaderProxy(PathManager.solvePetBuff(val.buffPic),new Rectangle(0,0,20 / this.scaleX,20 / this.scaleY));
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
      
      private function isContainerBuff(buff:FightBuffInfo) : Boolean
      {
         return buff.type == 2 || buff.type == 3 || buff.type == 4;
      }
      
      private function isActivityDunBuff(buff:FightBuffInfo) : Boolean
      {
         return buff.displayid == 114 || buff.displayid == 115;
      }
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "7,6,5,1,6,4";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 6;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 6;
      }
      
      public function set tipGapV(value:int) : void
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
      
      public function set tipStyle(value:String) : void
      {
      }
   }
}
