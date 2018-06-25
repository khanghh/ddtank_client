package bombKing.components
{
   import bombKing.data.BKingPlayerInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BKingLine extends Sprite implements Disposeable
   {
       
      
      private var _darkLine:Bitmap;
      
      private var _lightLine:Bitmap;
      
      private var _place:int;
      
      public function BKingLine(place:int)
      {
         super();
         _place = place;
         initView();
      }
      
      private function initView() : void
      {
         switch(int(_place) - 2)
         {
            case 0:
            case 1:
               _darkLine = ComponentFactory.Instance.creat("bombKing.leftRightDark");
               _lightLine = ComponentFactory.Instance.creat("bombKing.leftRightLight");
               break;
            case 2:
            case 3:
            case 4:
            case 5:
               _darkLine = ComponentFactory.Instance.creat("bombKing.upDownDark");
               _lightLine = ComponentFactory.Instance.creat("bombKing.upDownLight");
               break;
            case 6:
               _darkLine = ComponentFactory.Instance.creat("bombKing.downLeftDark");
               _lightLine = ComponentFactory.Instance.creat("bombKing.downLeftLight");
               break;
            case 7:
            case 8:
            case 9:
               _darkLine = ComponentFactory.Instance.creat("bombKing.upLeftDark");
               _lightLine = ComponentFactory.Instance.creat("bombKing.upLeftLight");
               break;
            case 10:
               _darkLine = ComponentFactory.Instance.creat("bombKing.downRightDark");
               _lightLine = ComponentFactory.Instance.creat("bombKing.downRightLight");
               break;
            case 11:
            case 12:
            case 13:
               _darkLine = ComponentFactory.Instance.creat("bombKing.upRightDark");
               _lightLine = ComponentFactory.Instance.creat("bombKing.upRightLight");
         }
         addChild(_darkLine);
         addChild(_lightLine);
         _lightLine.visible = false;
      }
      
      public function set info(info:BKingPlayerInfo) : void
      {
         if(info && info.status == 1)
         {
            _lightLine.visible = true;
            _darkLine.visible = false;
         }
         else
         {
            _lightLine.visible = false;
            _darkLine.visible = true;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_darkLine);
         _darkLine = null;
         ObjectUtils.disposeObject(_lightLine);
         _lightLine = null;
      }
   }
}
