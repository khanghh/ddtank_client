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
         var i:int = 0;
         var sp:* = null;
         var goodTipInfo:* = null;
         var itemInfo:* = null;
         var packsLevelBitmap:* = null;
         var packsMovie:* = null;
         _progressLine1 = ComponentFactory.Instance.creatBitmap("assets.chickActivation.levelPacksProgressBg");
         PositionUtils.setPos(_progressLine1,"chickActivation.progressLinePos1");
         addChild(_progressLine1);
         _progressLine2 = ComponentFactory.Instance.creatBitmap("assets.chickActivation.levelPacksProgressBg");
         PositionUtils.setPos(_progressLine2,"chickActivation.progressLinePos2");
         addChild(_progressLine2);
         _drawProgress1Data = ComponentFactory.Instance.creatBitmapData("assets.chickActivation.levelPacksProgress1");
         _drawProgress2Data = ComponentFactory.Instance.creatBitmap("assets.chickActivation.levelPacksProgress2");
         var levelDataArr:Array = ChickActivationManager.instance.model.itemInfoList[12];
         for(i = 0; i < packsLevelArr.length; )
         {
            sp = new LevelPacksComponent();
            goodTipInfo = new GoodTipInfo();
            if(levelDataArr)
            {
               itemInfo = ChickActivationManager.instance.model.getInventoryItemInfo(levelDataArr[i]);
               goodTipInfo.itemInfo = itemInfo;
            }
            sp.tipData = goodTipInfo;
            packsLevelBitmap = ComponentFactory.Instance.creatBitmap("assets.chickActivation.packsLevel_" + packsLevelArr[i].level);
            PositionUtils.setPos(packsLevelBitmap,"chickActivation.packsLevelBitmapPos");
            packsMovie = ClassUtils.CreatInstance("assets.chickActivation.packsMovie");
            packsMovie.gotoAndStop(1);
            PositionUtils.setPos(packsMovie,"chickActivation.packsMoviePos");
            packsMovie.mouseChildren = false;
            packsMovie.mouseEnabled = false;
            sp.levelIndex = i + 1;
            sp.addChild(packsLevelBitmap);
            sp.addChild(packsMovie);
            sp.x = i % 6 * 95;
            sp.y = int(i / 6) * 80;
            addChild(sp);
            packsLevelArr[i].movie = packsMovie;
            packsLevelArr[i].sp = sp;
            i++;
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",__levelItemsClickHandler);
      }
      
      private function __levelItemsClickHandler(evt:MouseEvent) : void
      {
         var component:* = null;
         var levelIndex:int = 0;
         if(evt.target is LevelPacksComponent)
         {
            component = LevelPacksComponent(evt.target);
            if(component.isGray)
            {
               levelIndex = LevelPacksComponent(evt.target).levelIndex;
               dispatchEvent(new ChickActivationEvent("clickLevelPacks",levelIndex));
            }
         }
      }
      
      public function update() : void
      {
         var levelIndex:* = 0;
         var grade:int = 0;
         var i:int = 0;
         var j:int = 0;
         var movie:* = null;
         var bool:Boolean = false;
         var model:ChickActivationModel = ChickActivationManager.instance.model;
         var day:int = model.getRemainingDay();
         if(model.isKeyOpened > 0 && day > 0)
         {
            levelIndex = -1;
            grade = PlayerManager.Instance.Self.Grade;
            for(i = 0; i < packsLevelArr.length; )
            {
               if(packsLevelArr[i].level <= grade)
               {
                  levelIndex = i;
               }
               i++;
            }
            if(levelIndex == -1)
            {
               return;
            }
            if(levelIndex > 5)
            {
               updateProgressLine(_progressLine1,5);
               updateProgressLine(_progressLine2,levelIndex - 6);
            }
            else
            {
               updateProgressLine(_progressLine1,levelIndex);
            }
            for(j = 0; j <= levelIndex; )
            {
               movie = MovieClip(packsLevelArr[j].movie);
               bool = ChickActivationManager.instance.model.getGainLevel(j + 1);
               if(bool)
               {
                  movie.gotoAndStop(1);
                  LevelPacksComponent(packsLevelArr[j].sp).buttonGrayFilters(bool);
               }
               else
               {
                  movie.gotoAndStop(2);
                  LevelPacksComponent(packsLevelArr[j].sp).buttonGrayFilters(bool);
               }
               j++;
            }
         }
      }
      
      private function updateProgressLine(_progressLine:Bitmap, _phases:int) : void
      {
         var i:int = 0;
         if(_phases < 0)
         {
            return;
         }
         var tempW:* = 95;
         for(i = 0; i <= _phases; )
         {
            _progressLine.bitmapData.copyPixels(_drawProgress1Data,_drawProgress1Data.rect,new Point(tempW * i,0),null,null,true);
            if(i != 0)
            {
               _progressLine.bitmapData.copyPixels(_drawProgress2Data.bitmapData,_drawProgress2Data.bitmapData.rect,new Point(tempW * (i - 1) + _drawProgress1Data.width - 7,2),null,null,true);
            }
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__levelItemsClickHandler);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         if(packsLevelArr)
         {
            for(i = 0; i < packsLevelArr.length; )
            {
               if(packsLevelArr[i].sp)
               {
                  ObjectUtils.disposeAllChildren(packsLevelArr[i].sp);
                  ObjectUtils.disposeObject(packsLevelArr[i].sp);
                  packsLevelArr[i].sp = null;
               }
               i++;
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
