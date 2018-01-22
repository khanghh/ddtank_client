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
      
      public function refreshView(param1:int, param2:int) : void
      {
         _level = param1;
         ObjectUtils.disposeObject(_skillCell);
         _skillCell = null;
         var _loc3_:HorseTemplateVo = HorseManager.instance.getHorseTemplateInfoByLevel(_level);
         if(_loc3_)
         {
            if(_loc3_.SkillID > 0)
            {
               _bg.visible = false;
               _bg2.visible = true;
               _skillCell = new HorseSkillCell(_loc3_.SkillID);
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
            if(_level <= param2)
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
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.horse.frame.starOpenMc");
         _loc1_.mouseEnabled = false;
         _loc1_.mouseChildren = false;
         addChild(_loc1_);
         var _loc2_:MovieClipWrapper = new MovieClipWrapper(_loc1_,true,true);
         _loc2_.addEventListener("complete",playEndHandler);
      }
      
      private function playEndHandler(param1:Event) : void
      {
         var _loc2_:MovieClipWrapper = param1.currentTarget as MovieClipWrapper;
         _loc2_.removeEventListener("complete",playEndHandler);
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
