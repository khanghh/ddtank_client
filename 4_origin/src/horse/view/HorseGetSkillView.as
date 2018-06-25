package horse.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.utils.MovieClipWrapper;
   
   public class HorseGetSkillView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _skillCell:HorseSkillCell;
      
      public function HorseGetSkillView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.getSkillView.bg");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("horse.getSkillView.getBtn");
         addChild(_bg);
         addChild(_getBtn);
      }
      
      public function show(skillId:int) : void
      {
         var mc1:MovieClip = ComponentFactory.Instance.creat("asset.horse.getSkillView.mc1");
         mc1.mouseChildren = false;
         mc1.mouseEnabled = false;
         mc1.x = 53;
         mc1.y = -104;
         addChild(mc1);
         var mcw:MovieClipWrapper = new MovieClipWrapper(mc1,true,true);
         mcw.addEventListener("complete",completeMc1);
         _skillCell = new HorseSkillCell(skillId,false);
         if(skillId == 10601)
         {
            _skillCell.x = 217;
            _skillCell.y = 63;
         }
         else if(skillId == 11101 || skillId == 11301)
         {
            _skillCell.x = 219;
            _skillCell.y = 65;
         }
         else
         {
            _skillCell.x = 228;
            _skillCell.y = 72;
         }
         addChild(_skillCell);
         this.x = 430;
         this.y = 220;
         this.scaleX = 0.3;
         this.scaleY = 0.3;
         this.alpha = 0;
         TweenLite.to(this,0.2,{
            "x":237,
            "y":141,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      private function completeMc1(event:Event) : void
      {
         var mcw:MovieClipWrapper = event.currentTarget as MovieClipWrapper;
         mcw.removeEventListener("complete",completeMc1);
         _getBtn.addEventListener("click",getClickHandler,false,0,true);
      }
      
      private function getClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _getBtn.removeEventListener("click",getClickHandler);
         var mc2:MovieClip = ComponentFactory.Instance.creat("asset.horse.getSkillView.mc2");
         mc2.mouseChildren = false;
         mc2.mouseEnabled = false;
         mc2.x = 84;
         mc2.y = -72;
         addChild(mc2);
         var mcw:MovieClipWrapper = new MovieClipWrapper(mc2,true,true);
         mcw.addEventListener("complete",completeMc2);
         var tmpPos:Point = this.localToGlobal(new Point(_skillCell.x,_skillCell.y));
         LayerManager.Instance.addToLayer(_skillCell,0);
         _skillCell.x = tmpPos.x;
         _skillCell.y = tmpPos.y;
         TweenLite.to(this,1,{"alpha":0});
         TweenLite.to(_skillCell,1,{
            "x":_skillCell.x,
            "y":_skillCell.y - 3,
            "onComplete":skillCellMoveComplete1
         });
      }
      
      private function skillCellMoveComplete1() : void
      {
         TweenLite.to(_skillCell,0.2,{
            "x":733,
            "y":313,
            "scaleX":0.3,
            "scaleY":0.3,
            "onComplete":skillCellMoveComplete2
         });
      }
      
      private function skillCellMoveComplete2() : void
      {
         TweenLite.to(_skillCell,0.16,{
            "x":730,
            "y":305,
            "scaleX":0.5,
            "scaleY":0.5,
            "onComplete":skillCellMoveComplete3
         });
      }
      
      private function skillCellMoveComplete3() : void
      {
         TweenLite.to(_skillCell,0.16,{
            "alpha":0,
            "onComplete":skillCellMoveComplete4
         });
      }
      
      private function skillCellMoveComplete4() : void
      {
         ObjectUtils.disposeObject(_skillCell);
         _skillCell = null;
      }
      
      private function completeMc2(event:Event) : void
      {
         var mcw:MovieClipWrapper = event.currentTarget as MovieClipWrapper;
         mcw.removeEventListener("complete",completeMc2);
         if(parent)
         {
            parent.removeChild(this);
         }
         var mc3:MovieClip = ComponentFactory.Instance.creat("asset.horse.getSkillView.mc3");
         mc3.mouseChildren = false;
         mc3.mouseEnabled = false;
         mc3.x = 548;
         mc3.y = 113;
         addChild(mc3);
         LayerManager.Instance.addToLayer(mc3,1);
         var mcw2:MovieClipWrapper = new MovieClipWrapper(mc3,true,true);
         mcw2.addEventListener("complete",completeMc3);
      }
      
      private function completeMc3(event:Event) : void
      {
         var mcw:MovieClipWrapper = event.currentTarget as MovieClipWrapper;
         mcw.removeEventListener("complete",completeMc3);
         dispose();
      }
      
      public function dispose() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",getClickHandler);
         }
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_skillCell);
         _bg = null;
         _getBtn = null;
         _skillCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
