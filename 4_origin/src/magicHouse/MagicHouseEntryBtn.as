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
      
      public function MagicHouseEntryBtn()
      {
         super();
         _entryBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.hallStateView.entryBtn.alpha");
         addChild(_entryBtn);
         _content = new Sprite();
         _iconMc = ComponentFactory.Instance.creat("asset.hallIcon.magichouseIcon");
         _content.addChild(_iconMc);
      }
      
      public function get content() : Sprite
      {
         return _content;
      }
      
      override public function dispose() : void
      {
         if(_entryBtn)
         {
            ObjectUtils.disposeObject(_entryBtn);
         }
         _entryBtn = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_iconMc)
         {
            ObjectUtils.disposeObject(_entryBtn);
         }
         _iconMc = null;
         super.dispose();
      }
   }
}
