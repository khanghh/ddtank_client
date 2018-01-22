package mysteriousRoullete.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mysteriousRoullete.MysteriousControl;
   import mysteriousRoullete.MysteriousManager;
   import mysteriousRoullete.event.MysteriousEvent;
   import wonderfulActivity.views.IRightView;
   
   public class MysteriousActivityView extends Sprite implements IRightView
   {
       
      
      private var _content:Sprite;
      
      private var _bg:Bitmap;
      
      private var _view:Sprite;
      
      public var type:int = 0;
      
      public function MysteriousActivityView()
      {
         super();
         MysteriousControl.instance.loadMysteriousRouletteModule(init2);
         MysteriousManager.instance.addEventListener("mysteriousSetTime",__onSetTime);
      }
      
      public function init() : void
      {
      }
      
      public function init2() : void
      {
         MysteriousControl.instance.setView(this);
         _content = new Sprite();
         PositionUtils.setPos(_content,"mysteriousRoulette.ContentPos");
         _bg = ComponentFactory.Instance.creat("mysteriousRoulette.BG");
         _content.addChild(_bg);
         type = MysteriousManager.instance.viewType;
         switch(int(type))
         {
            case 0:
               _view = new MysteriousRouletteView();
               _view.addEventListener("changeView",changeViewHandler);
               break;
            case 1:
               _view = new MysteriousShopView();
               MysteriousManager.instance.mysteriousViewFlag = true;
         }
         _content.addChild(_view);
         addChild(_content);
      }
      
      private function changeViewHandler(param1:MysteriousEvent) : void
      {
         if(!_view || type == param1.viewType)
         {
            return;
         }
         _view.removeEventListener("changeView",changeViewHandler);
         ObjectUtils.disposeObject(_view);
         _view = null;
         type = param1.viewType;
         switch(int(type))
         {
            case 0:
               _view = new MysteriousRouletteView();
               _view.addEventListener("changeView",changeViewHandler);
               break;
            case 1:
               _view = new MysteriousShopView();
               MysteriousManager.instance.mysteriousViewFlag = true;
         }
         _content.addChild(_view);
      }
      
      protected function __onSetTime(param1:MysteriousEvent) : void
      {
         if(_view && type == 1)
         {
            (_view as MysteriousShopView).setTimes();
         }
      }
      
      private function removeEvent() : void
      {
         if(_view)
         {
            _view.removeEventListener("changeView",changeViewHandler);
         }
         MysteriousManager.instance.removeEventListener("mysteriousSetTime",__onSetTime);
      }
      
      public function dispose() : void
      {
         removeEvent();
         MysteriousControl.instance.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      public function get view() : Sprite
      {
         return _view;
      }
   }
}
