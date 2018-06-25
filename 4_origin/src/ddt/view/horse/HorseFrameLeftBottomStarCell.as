package ddt.view.horse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import horse.HorseManager;
   import horse.data.HorseTemplateVo;
   import road7th.utils.MovieClipWrapper;
   
   public class HorseFrameLeftBottomStarCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _normalMc:MovieClip;
      
      private var _level:int;
      
      private var _isOpen:Boolean = false;
      
      private var _skillCell:HorseSkillCell;
      
      public function HorseFrameLeftBottomStarCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.frame.starBg");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.horse.frame.starBg2");
         _normalMc = ComponentFactory.Instance.creat("asset.horse.frame.starMc");
         _normalMc.mouseChildren = false;
         _normalMc.mouseEnabled = false;
         _normalMc.gotoAndStop(2);
         addChild(_bg);
         addChild(_bg2);
         addChild(_normalMc);
      }
      
      public function refreshView(index:int, curLevel:int) : void
      {
         _level = index;
         ObjectUtils.disposeObject(_skillCell);
         _skillCell = null;
         var tmp:HorseTemplateVo = HorseManager.instance.getHorseTemplateInfoByLevel(_level);
         if(tmp)
         {
            if(tmp.SkillID > 0)
            {
               _bg.visible = false;
               _bg2.visible = true;
               _skillCell = new HorseSkillCell(tmp.SkillID);
               _skillCell.scaleX = _bg2.width / _skillCell.width;
               _skillCell.scaleY = _bg2.height / _skillCell.height;
               _skillCell.alpha = 0;
               addChild(_skillCell);
            }
            else
            {
               _bg.visible = true;
               _bg2.visible = false;
            }
            if(_level <= curLevel)
            {
               if(!_isOpen)
               {
                  openHandler();
               }
            }
            else
            {
               _normalMc.gotoAndStop(2);
               _isOpen = false;
            }
         }
         else
         {
            _bg.visible = true;
            _bg2.visible = false;
            _normalMc.gotoAndStop(2);
            _isOpen = false;
         }
      }
      
      private function openHandler() : void
      {
         var openMc:MovieClip = ComponentFactory.Instance.creat("asset.horse.frame.starOpenMc");
         openMc.mouseEnabled = false;
         openMc.mouseChildren = false;
         addChild(openMc);
         var tmp:MovieClipWrapper = new MovieClipWrapper(openMc,true,true);
         tmp.addEventListener("complete",playEndHandler);
      }
      
      private function playEndHandler(event:Event) : void
      {
         var tmp:MovieClipWrapper = event.currentTarget as MovieClipWrapper;
         tmp.removeEventListener("complete",playEndHandler);
         if(_normalMc)
         {
            _normalMc.gotoAndStop(1);
         }
         _isOpen = true;
      }
      
      public function dispose() : void
      {
         if(_normalMc)
         {
            _normalMc.gotoAndStop(2);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _bg2 = null;
         _normalMc = null;
         _skillCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
