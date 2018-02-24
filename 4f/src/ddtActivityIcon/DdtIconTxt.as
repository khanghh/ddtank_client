package ddtActivityIcon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.view.ConsortiaBattleEntryBtn;
   import flash.display.Sprite;
   import worldboss.view.WorldBossIcon;
   
   public class DdtIconTxt extends Sprite
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _isOver:Boolean;
      
      private var _sp:Sprite;
      
      private var _isOpen:Boolean;
      
      public function DdtIconTxt(){super();}
      
      public function addActIcon(param1:Sprite) : void{}
      
      public function resetPos() : void{}
      
      public function set isOver(param1:Boolean) : void{}
      
      public function get isOver() : Boolean{return false;}
      
      public function set isOpen(param1:Boolean) : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      private function initView() : void{}
      
      public function setTxt(param1:String) : void{}
      
      public function resetTxt() : void{}
      
      public function dispose() : void{}
      
      public function get sp() : Sprite{return null;}
   }
}
