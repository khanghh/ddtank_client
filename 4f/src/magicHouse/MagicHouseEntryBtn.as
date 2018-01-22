package magicHouse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class MagicHouseEntryBtn extends Component
   {
       
      
      private var _entryBtn:BaseButton;
      
      private var _content:Sprite;
      
      private var _iconMc:MovieClip;
      
      public function MagicHouseEntryBtn(){super();}
      
      public function get content() : Sprite{return null;}
      
      override public function dispose() : void{}
   }
}
