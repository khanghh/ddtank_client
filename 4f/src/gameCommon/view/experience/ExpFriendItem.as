package gameCommon.view.experience
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import gameCommon.GameControl;
   import gameCommon.model.Player;
   import gameCommon.view.playerThumbnail.HeadFigure;
   
   public class ExpFriendItem extends Sprite implements Disposeable
   {
       
      
      private var _head:HeadFigure;
      
      private var _nameTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _exploitTxt:FilterFrameText;
      
      private var _attestBtn:ScaleFrameImage;
      
      public function ExpFriendItem(param1:Player){super();}
      
      private function init(param1:Player) : void{}
      
      public function dispose() : void{}
   }
}
