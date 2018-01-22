package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseFrameLeftBottomStarCell;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import horse.HorseManager;
   
   public class HorseFrameLeftBottomView extends Sprite implements Disposeable
   {
       
      
      private var _levelStarTxtImage:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _starTxt:FilterFrameText;
      
      private var _starCellList:Vector.<HorseFrameLeftBottomStarCell>;
      
      private var _progressTxtImage:Bitmap;
      
      private var _progressBg:Bitmap;
      
      private var _progressCover:Bitmap;
      
      private var _progressCoverTemp:Bitmap;
      
      private var _progressBarMask:Shape;
      
      private var _progressBarMaskTemp:Shape;
      
      private var _progressTxt:FilterFrameText;
      
      public function HorseFrameLeftBottomView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _levelStarTxtImage = ComponentFactory.Instance.creatBitmap("asset.horse.frame.levelStarTxtImage");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelStarTxt");
         _starTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelStarTxt");
         PositionUtils.setPos(_starTxt,"horse.frame.starTxtPos");
         addChild(_levelStarTxtImage);
         addChild(_levelTxt);
         addChild(_starTxt);
         _starCellList = new Vector.<HorseFrameLeftBottomStarCell>();
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = new HorseFrameLeftBottomStarCell();
            _loc1_.x = 76 + 35 * _loc2_;
            _loc1_.y = 345;
            addChild(_loc1_);
            _starCellList.push(_loc1_);
            _loc2_++;
         }
         _progressTxtImage = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressTxtImage");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressBg");
         _progressCover = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressCover");
         _progressBarMask = creatMask(_progressCover);
         _progressCoverTemp = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressCover2");
         _progressBarMaskTemp = creatMask(_progressCoverTemp);
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.progressTxt");
         _progressTxt.text = "0/0";
         addChild(_progressTxtImage);
         addChild(_progressBg);
         addChild(_progressCoverTemp);
         addChild(_progressCover);
         addChild(_progressBarMaskTemp);
         addChild(_progressBarMask);
         addChild(_progressTxt);
      }
      
      private function creatMask(param1:DisplayObject) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,1);
         _loc2_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc2_.graphics.endFill();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         param1.mask = _loc2_;
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         HorseManager.instance.addEventListener("horseUpHorseStep2",upHorseHandler);
      }
      
      private function upHorseHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = HorseManager.instance.curLevel;
         _levelTxt.text = (int(_loc4_ / 10 + 1)).toString();
         _starTxt.text = String(_loc4_ % 10);
         var _loc3_:int = int(_loc4_ / 10) * 10;
         _loc8_ = 0;
         while(_loc8_ < 9)
         {
            _starCellList[_loc8_].refreshView(_loc3_ + _loc8_ + 1,_loc4_);
            _loc8_++;
         }
         if(_loc4_ >= 89)
         {
            _progressTxt.text = "0/0";
            _progressBarMask.scaleX = 1;
            _progressCover.scaleX = 1;
         }
         else
         {
            _loc5_ = HorseManager.instance.nextHorseTemplateInfo.Experience;
            _loc2_ = HorseManager.instance.curHorseTemplateInfo.Experience;
            _loc6_ = HorseManager.instance.curExp - _loc2_;
            _loc7_ = HorseManager.instance.curExp + HorseManager.instance.tempExp - _loc2_;
            _loc1_ = _loc5_ - _loc2_;
            _progressTxt.text = _loc6_ + HorseManager.instance.tempExp + "/" + _loc1_;
            _progressBarMask.scaleX = _loc6_ / _loc1_;
            if(_loc7_ / _loc1_ <= 1)
            {
               _progressBarMaskTemp.scaleX = _loc7_ / _loc1_;
            }
            else
            {
               _progressCoverTemp.scaleX = 1;
            }
         }
      }
      
      private function removeEvent() : void
      {
         HorseManager.instance.removeEventListener("horseUpHorseStep2",upHorseHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _levelStarTxtImage = null;
         _levelTxt = null;
         _starTxt = null;
         _starCellList = null;
         _progressTxtImage = null;
         _progressBg = null;
         _progressCover = null;
         _progressCoverTemp = null;
         _progressTxt = null;
         _progressBarMask = null;
         _progressBarMaskTemp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
