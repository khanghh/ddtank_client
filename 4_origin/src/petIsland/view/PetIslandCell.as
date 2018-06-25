package petIsland.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petIsland.PetIslandManager;
   import petIsland.event.PetIslandEvent;
   
   public class PetIslandCell extends Sprite
   {
       
      
      private var cell:MovieClip;
      
      private var _type:int;
      
      public var _row:int;
      
      public var _col:int;
      
      private var _isShine:Boolean;
      
      public function PetIslandCell(type:int, row:int, col:int)
      {
         super();
         _type = type;
         _row = row;
         _col = col;
         init();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get isShine() : Boolean
      {
         return _isShine;
      }
      
      public function set isShine(value:Boolean) : void
      {
         _isShine = value;
         cell["shine"].visible = _isShine;
      }
      
      private function init() : void
      {
         cell = ComponentFactory.Instance.creat("asset.petIsland.cell" + _type);
         cell["shine"].visible = false;
         addChild(cell);
         cell.addEventListener("click",cellClickHandler);
      }
      
      public function destroy() : void
      {
         TweenLite.to(cell["cellMc"],0.4,{
            "alpha":0,
            "onComplete":tweenComplete
         });
         cell["breakMc"].gotoAndPlay(2);
      }
      
      private function tweenComplete() : void
      {
         PetIslandManager.instance.dispatchEvent(new PetIslandEvent("destroy",this));
      }
      
      private function cellClickHandler(e:MouseEvent) : void
      {
         PetIslandManager.instance.dispatchEvent(new PetIslandEvent("pet_click",this));
      }
      
      public function clearShine() : void
      {
         cell["shine"].visible = false;
      }
   }
}
