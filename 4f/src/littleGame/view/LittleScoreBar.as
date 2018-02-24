package littleGame.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.events.PlayerPropertyEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class LittleScoreBar extends Sprite implements Disposeable
   {
       
      
      private var _self:SelfInfo;
      
      private var _back:DisplayObject;
      
      private var _scoreField:GradientText;
      
      public function LittleScoreBar(param1:SelfInfo){super();}
      
      private function configUI() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __selfPropertyChanged(param1:PlayerPropertyEvent) : void{}
      
      public function dispose() : void{}
   }
}
