package consortion.view.selfConsortia
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.BadgeInfo;
   import ddt.manager.BadgeInfoManager;
   import ddt.manager.PathManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Badge extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const LARGE:String = "large";
      
      public static const NORMAL:String = "normal";
      
      public static const SMALL:String = "small";
      
      private static const LARGE_SIZE:int = 78;
      
      private static const NORMAL_SIZE:int = 48;
      
      private static const SMALL_SIZE:int = 28;
       
      
      private var _size:String = "large";
      
      private var _badgeID:int = -1;
      
      private var _buyDate:Date;
      
      private var _badge:Bitmap;
      
      private var _loader:BitmapLoader;
      
      private var _clickEnale:Boolean = false;
      
      private var _tipInfo:Object;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String = "consortion.view.selfConsortia.BadgeTip";
      
      private var _showTip:Boolean;
      
      public function Badge(size:String = "small")
      {
         super();
         _size = size;
         graphics.beginFill(16777215,0);
         var s:int = 0;
         if(_size == "large")
         {
            s = 78;
         }
         else if(_size == "normal")
         {
            s = 48;
         }
         else if(_size == "small")
         {
            s = 28;
         }
         graphics.drawRect(0,0,s,s);
         graphics.endFill();
         _tipGapV = 5;
         _tipGapH = 5;
         _tipDirctions = "7,6,5";
         if(_size == "small")
         {
            _tipStyle = "ddt.view.tips.OneLineTip";
         }
         else
         {
            _tipStyle = "consortion.view.selfConsortia.BadgeTip";
         }
      }
      
      public function get showTip() : Boolean
      {
         return _showTip;
      }
      
      public function set showTip(value:Boolean) : void
      {
         _showTip = value;
         if(_showTip)
         {
            ShowTipManager.Instance.addTip(this);
         }
         else
         {
            ShowTipManager.Instance.removeTip(this);
         }
      }
      
      public function get clickEnale() : Boolean
      {
         return _clickEnale;
      }
      
      public function set clickEnale(value:Boolean) : void
      {
         if(value == _clickEnale)
         {
            return;
         }
         _clickEnale = value;
         if(_clickEnale)
         {
            addEventListener("click",onClick);
         }
         else
         {
            removeEventListener("click",onClick);
         }
      }
      
      private function onClick(event:MouseEvent) : void
      {
         var shopFrame:BadgeShopFrame = ComponentFactory.Instance.creatComponentByStylename("consortion.badgeShopFrame");
         LayerManager.Instance.addToLayer(shopFrame,3,true);
      }
      
      public function get buyDate() : Date
      {
         return _buyDate;
      }
      
      public function set buyDate(value:Date) : void
      {
         _buyDate = value;
      }
      
      public function get badgeID() : int
      {
         return _badgeID;
      }
      
      public function set badgeID(value:int) : void
      {
         if(value == _badgeID)
         {
            return;
         }
         _badgeID = value;
         getTipInfo();
         updateView();
      }
      
      private function getTipInfo() : void
      {
         _tipInfo = {};
         var badgeinfo:BadgeInfo = BadgeInfoManager.instance.getBadgeInfoByID(_badgeID);
         if(badgeinfo)
         {
            _tipInfo.name = badgeinfo.BadgeName;
            _tipInfo.LimitLevel = badgeinfo.LimitLevel;
            _tipInfo.ValidDate = badgeinfo.ValidDate;
            if(_buyDate)
            {
               _tipInfo.buyDate = _buyDate;
            }
         }
      }
      
      private function updateView() : void
      {
         removeBadge();
         _loader = LoadResourceManager.Instance.createLoader(PathManager.solveBadgePath(_badgeID),0);
         _loader.addEventListener("complete",onComplete);
         _loader.addEventListener("loadError",onError);
         LoadResourceManager.Instance.startLoad(_loader);
      }
      
      private function removeBadge() : void
      {
         if(_badge)
         {
            if(_badge.parent)
            {
               _badge.parent.removeChild(_badge);
            }
            _badge.bitmapData.dispose();
            _badge = null;
         }
      }
      
      private function onComplete(event:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",onComplete);
         _loader.removeEventListener("loadError",onError);
         if(_loader.isSuccess)
         {
            _badge = _loader.content as Bitmap;
            _badge.smoothing = true;
            if(_size == "large")
            {
               var _loc2_:int = 78;
               _badge.height = _loc2_;
               _badge.width = _loc2_;
            }
            else if(_size == "normal")
            {
               _loc2_ = 48;
               _badge.height = _loc2_;
               _badge.width = _loc2_;
            }
            else
            {
               _loc2_ = 28;
               _badge.height = _loc2_;
               _badge.width = _loc2_;
            }
            addChild(_badge);
         }
      }
      
      private function onError(event:LoaderEvent) : void
      {
         _loader.removeEventListener("complete",onComplete);
         _loader.removeEventListener("loadError",onError);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipInfo = value;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeObject(_badge);
         _badge = null;
         if(_loader)
         {
            _loader.removeEventListener("complete",onComplete);
            _loader.removeEventListener("loadError",onError);
         }
         _loader = null;
         _tipInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
