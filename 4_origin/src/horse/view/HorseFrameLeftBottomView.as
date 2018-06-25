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
      
      private var _progressBarMask:Shape;
      
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
         var i:int = 0;
         var tmp:* = null;
         _levelStarTxtImage = ComponentFactory.Instance.creatBitmap("asset.horse.frame.levelStarTxtImage");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelStarTxt");
         _starTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.levelStarTxt");
         PositionUtils.setPos(_starTxt,"horse.frame.starTxtPos");
         addChild(_levelStarTxtImage);
         addChild(_levelTxt);
         addChild(_starTxt);
         _starCellList = new Vector.<HorseFrameLeftBottomStarCell>();
         for(i = 0; i < 9; )
         {
            tmp = new HorseFrameLeftBottomStarCell();
            tmp.x = 76 + 43 * i;
            tmp.y = 345;
            addChild(tmp);
            _starCellList.push(tmp);
            i++;
         }
         _progressTxtImage = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressTxtImage");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressBg");
         _progressCover = ComponentFactory.Instance.creatBitmap("asset.horse.frame.progressCover");
         _progressBarMask = creatMask(_progressCover);
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.progressTxt");
         _progressTxt.text = "0/0";
         addChild(_progressTxtImage);
         addChild(_progressBg);
         addChild(_progressCover);
         addChild(_progressBarMask);
         addChild(_progressTxt);
      }
      
      private function creatMask(source:DisplayObject) : Shape
      {
         var result:Shape = new Shape();
         result.graphics.beginFill(16711680,1);
         result.graphics.drawRect(0,0,source.width,source.height);
         result.graphics.endFill();
         result.x = source.x;
         result.y = source.y;
         source.mask = result;
         return result;
      }
      
      private function initEvent() : void
      {
         HorseManager.instance.addEventListener("horseUpHorseStep2",upHorseHandler);
      }
      
      private function upHorseHandler(event:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var i:int = 0;
         var nextNeedTotalExp:int = 0;
         var curNeedTotalExp:int = 0;
         var curHasExp:int = 0;
         var curTempExp:int = 0;
         var nextNeedExp:int = 0;
         var curLevel:int = HorseManager.instance.curLevel;
         _levelTxt.text = (int(curLevel / 10 + 1)).toString();
         _starTxt.text = String(curLevel % 10);
         var startIndex:int = int(curLevel / 10) * 10;
         for(i = 0; i < 9; )
         {
            _starCellList[i].refreshView(startIndex + i + 1,curLevel);
            i++;
         }
         if(curLevel >= 89)
         {
            _progressTxt.text = "0/0";
            _progressBarMask.scaleX = 1;
            _progressCover.scaleX = 1;
         }
         else
         {
            nextNeedTotalExp = HorseManager.instance.nextHorseTemplateInfo.Experience;
            curNeedTotalExp = HorseManager.instance.curHorseTemplateInfo.Experience;
            curHasExp = HorseManager.instance.curExp - curNeedTotalExp;
            curTempExp = HorseManager.instance.curExp + HorseManager.instance.tempExp - curNeedTotalExp;
            nextNeedExp = nextNeedTotalExp - curNeedTotalExp;
            _progressTxt.text = curHasExp + HorseManager.instance.tempExp + "/" + nextNeedExp;
            _progressBarMask.scaleX = curHasExp / nextNeedExp;
            if(curTempExp / nextNeedExp > 1)
            {
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
         _progressTxt = null;
         _progressBarMask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
