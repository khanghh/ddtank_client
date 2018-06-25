package par.creators
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class DefaultCreator implements IParticalCreator
   {
       
      
      public function DefaultCreator()
      {
         super();
      }
      
      public function createPartical() : DisplayObject
      {
         var sprit:Sprite = new Sprite();
         sprit.graphics.beginFill(0);
         sprit.graphics.drawCircle(0,0,10);
         sprit.graphics.endFill();
         return sprit;
      }
   }
}
