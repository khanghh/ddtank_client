package ddt.view.caddyII.card
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.caddyII.CaddyBagView;
   import ddt.view.caddyII.CaddyModel;
   import ddt.view.caddyII.MoveSprite;
   import ddt.view.caddyII.badLuck.BadLuckView;
   import ddt.view.caddyII.reader.CaddyUpdate;
   import flash.display.DisplayObject;
   
   public class CardSoulBoxFrame extends Frame
   {
       
      
      private var _view:CardSoulView;
      
      private var _bag:CaddyBagView;
      
      private var _reader:CaddyUpdate;
      
      private var _moveSprite:MoveSprite;
      
      private var _itemInfo:ItemTemplateInfo;
      
      private var _type:int;
      
      public function CardSoulBoxFrame(type:int, itemInfo:ItemTemplateInfo = null)
      {
         super();
         _type = type;
         _itemInfo = itemInfo;
         initView(_type);
         initEvents();
      }
      
      private function initView(type:int) : void
      {
         escEnable = true;
         CaddyModel.instance.setup(type);
         _view = ComponentFactory.Instance.creatCustomObject("caddy.CardSoulView");
         _reader = CaddyModel.instance.readView;
         addToContent(_reader as DisplayObject);
         addToContent(_view);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         SocketManager.Instance.addEventListener(PkgEvent.format(38),__updateInfo);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         SocketManager.Instance.removeEventListener(PkgEvent.format(38),__updateInfo);
      }
      
      private function __updateInfo(e:PkgEvent) : void
      {
         if(_reader is BadLuckView)
         {
            _reader.update();
         }
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_view.closeEnble)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.cardSoulBox.dontClose"));
            return;
         }
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      public function setCardType(id:int, place:int) : void
      {
         _view.setCard(id,place);
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.cardSoulBox.title");
         LayerManager.Instance.addToLayer(this,3,true,1,true);
         y = y + -50;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
