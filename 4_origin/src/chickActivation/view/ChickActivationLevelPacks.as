package chickActivation.view
{
   import chickActivation.ChickActivationManager;
   import chickActivation.event.ChickActivationEvent;
   import chickActivation.model.ChickActivationModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ChickActivationLevelPacks extends Sprite implements Disposeable
   {
       
      
      public var packsLevelArr:Array;
      
      private var _arrData:Array;
      
      private var _progressLine1:Bitmap;
      
      private var _progressLine2:Bitmap;
      
      private var _drawProgress1Data:BitmapData;
      
      private var _drawProgress2Data:Bitmap;
      
      public function ChickActivationLevelPacks()
      {
         packsLevelArr = [{"level":25},{"level":30},{"level":35},{"level":40},{"level":45},{"level":48},{"level":50},{"level":52},{"level":55},{"level":60},{"level":65},{"level":70}];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         _progressLine1 = ComponentFactory.Instance.creatBitmap("assets.chickActivation.levelPacksProgressBg");
         PositionUtils.setPos(_progressLine1,"chickActivation.progressLinePos1");
         addChild(_progressLine1);
         _progressLine2 = ComponentFactory.Instance.creatBitmap("assets.chickActivation.levelPacksProgressBg");
         PositionUtils.setPos(_progressLine2,"chickActivation.progressLinePos2");
         addChild(_progressLine2);
         _drawProgress1Data = ComponentFactory.Instance.creatBitmapData("assets.chickActivation.levelPacksProgress1");
         _drawProgress2Data = ComponentFactory.Instance.creatBitmap("assets.chickActivation.levelPacksProgress2");
         var _loc3_:Array = ChickActivationManager.instance.model.itemInfoList[12];
         _loc7_ = 0;
         while(_loc7_ < packsLevelArr.length)
         {
            _loc1_ = new LevelPacksComponent();
            _loc2_ = new GoodTipInfo();
            if(_loc3_)
            {
               _loc5_ = ChickActivationManager.instance.model.getInventoryItemInfo(_loc3_[_loc7_]);
               _loc2_.itemInfo = _loc5_;
            }
            _loc1_.tipData = _loc2_;
            _loc4_ = ComponentFactory.Instance.creatBitmap("assets.chickActivation.packsLevel_" + packsLevelArr[_loc7_].level);
            PositionUtils.setPos(_loc4_,"chickActivation.packsLevelBitmapPos");
            _loc6_ = ClassUtils.CreatInstance("assets.chickActivation.packsMovie");
            _loc6_.gotoAndStop(1);
            PositionUtils.setPos(_loc6_,"chickActivation.packsMoviePos");
            _loc6_.mouseChildren = false;
            _loc6_.mouseEnabled = false;
            _loc1_.levelIndex = _loc7_ + 1;
            _loc1_.addChild(_loc4_);
            _loc1_.addChild(_loc6_);
            _loc1_.x = _loc7_ % 6 * 95;
            _loc1_.y = int(_loc7_ / 6) * 80;
            addChild(_loc1_);
            packsLevelArr[_loc7_].movie = _loc6_;
            packsLevelArr[_loc7_].sp = _loc1_;
            _loc7_++;
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__levelItemsClickHandler);
      }
      
      private function __levelItemsClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1.target is LevelPacksComponent)
         {
            _loc2_ = LevelPacksComponent(param1.target);
            if(_loc2_.isGray)
            {
               _loc3_ = LevelPacksComponent(param1.target).levelIndex;
               dispatchEvent(new ChickActivationEvent("clickLevelPacks",_loc3_));
            }
         }
      }
      
      public function update() : void
      {
         var _loc7_:* = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Boolean = false;
         var _loc1_:ChickActivationModel = ChickActivationManager.instance.model;
         var _loc5_:int = _loc1_.getRemainingDay();
         if(_loc1_.isKeyOpened > 0 && _loc5_ > 0)
         {
            _loc7_ = -1;
            _loc3_ = PlayerManager.Instance.Self.Grade;
            _loc8_ = 0;
            while(_loc8_ < packsLevelArr.length)
            {
               if(packsLevelArr[_loc8_].level <= _loc3_)
               {
                  _loc7_ = _loc8_;
               }
               _loc8_++;
            }
            if(_loc7_ == -1)
            {
               return;
            }
            if(_loc7_ > 5)
            {
               updateProgressLine(_progressLine1,5);
               updateProgressLine(_progressLine2,_loc7_ - 6);
            }
            else
            {
               updateProgressLine(_progressLine1,_loc7_);
            }
            _loc6_ = 0;
            while(_loc6_ <= _loc7_)
            {
               _loc2_ = MovieClip(packsLevelArr[_loc6_].movie);
               _loc4_ = ChickActivationManager.instance.model.getGainLevel(_loc6_ + 1);
               if(_loc4_)
               {
                  _loc2_.gotoAndStop(1);
                  LevelPacksComponent(packsLevelArr[_loc6_].sp).buttonGrayFilters(_loc4_);
               }
               else
               {
                  _loc2_.gotoAndStop(2);
                  LevelPacksComponent(packsLevelArr[_loc6_].sp).buttonGrayFilters(_loc4_);
               }
               _loc6_++;
            }
         }
      }
      
      private function updateProgressLine(param1:Bitmap, param2:int) : void
      {
         var _loc4_:int = 0;
         if(param2 < 0)
         {
            return;
         }
         var _loc3_:* = 95;
         _loc4_ = 0;
         while(_loc4_ <= param2)
         {
            param1.bitmapData.copyPixels(_drawProgress1Data,_drawProgress1Data.rect,new Point(_loc3_ * _loc4_,0),null,null,true);
            if(_loc4_ != 0)
            {
               param1.bitmapData.copyPixels(_drawProgress2Data.bitmapData,_drawProgress2Data.bitmapData.rect,new Point(_loc3_ * (_loc4_ - 1) + _drawProgress1Data.width - 7,2),null,null,true);
            }
            _loc4_++;
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__levelItemsClickHandler);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         if(packsLevelArr)
         {
            _loc1_ = 0;
            while(_loc1_ < packsLevelArr.length)
            {
               if(packsLevelArr[_loc1_].sp)
               {
                  ObjectUtils.disposeAllChildren(packsLevelArr[_loc1_].sp);
                  ObjectUtils.disposeObject(packsLevelArr[_loc1_].sp);
                  packsLevelArr[_loc1_].sp = null;
               }
               _loc1_++;
            }
            packsLevelArr = null;
         }
         ObjectUtils.disposeObject(_progressLine1);
         _progressLine1 = null;
         ObjectUtils.disposeObject(_progressLine2);
         _progressLine2 = null;
         ObjectUtils.disposeObject(_drawProgress1Data);
         _drawProgress1Data = null;
         ObjectUtils.disposeObject(_drawProgress2Data);
         _drawProgress2Data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
