package tryonSystem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class TryonSystemController
   {
      
      private static var _instance:TryonSystemController;
       
      
      private var _view:Frame;
      
      private var _modelDic:Dictionary;
      
      private var _sumbmintFunDic:Dictionary;
      
      private var _cancelFunDic:Dictionary;
      
      public function TryonSystemController()
      {
         super();
         _modelDic = new Dictionary();
         _sumbmintFunDic = new Dictionary();
         _cancelFunDic = new Dictionary();
      }
      
      public static function get Instance() : TryonSystemController
      {
         if(_instance == null)
         {
            _instance = new TryonSystemController();
         }
         return _instance;
      }
      
      public function getModelByView(view:Frame) : TryonModel
      {
         _view = view;
         return _modelDic[view];
      }
      
      public function get view() : Frame
      {
         return _view;
      }
      
      public function show(items:Array, submitFun:Function = null, cancelFun:Function = null) : void
      {
         if(_view)
         {
            return;
         }
         var model:TryonModel = new TryonModel(items);
         var sumFun:* = submitFun;
         var canFun:* = cancelFun;
         if(EquipType.isAvatar(InventoryItemInfo(items[0]).CategoryID))
         {
            _view = ComponentFactory.Instance.creatComponentByStylename("tryonSystem.tryonFrame") as TryonPanelFrame;
            _modelDic[_view] = model;
            TryonPanelFrame(_view).controller = this;
         }
         else
         {
            _view = ComponentFactory.Instance.creatComponentByStylename("tryonSystem.ChoosePanelFrame") as ChooseFrame;
            _modelDic[_view] = model;
            ChooseFrame(_view).controller = this;
         }
         if(sumFun != null)
         {
            _sumbmintFunDic[_view] = sumFun;
         }
         if(canFun != null)
         {
            _cancelFunDic[_view] = canFun;
         }
         _view.addEventListener("response",__onResponse);
         _view.addEventListener("removedFromStage",__onRemoved);
         LayerManager.Instance.addToLayer(_view,3,true,1,true);
      }
      
      private function __onRemoved(event:Event) : void
      {
         var model:* = null;
         if(_modelDic[_view])
         {
            model = _modelDic[_view];
            model.dispose();
            model = null;
            delete _modelDic[_view];
         }
         if(_view)
         {
            _view.removeEventListener("response",__onResponse);
         }
         if(_view)
         {
            _view.removeEventListener("removedFromStage",__onRemoved);
         }
         if(_sumbmintFunDic[_view])
         {
            _sumbmintFunDic[_view] = null;
         }
         if(_cancelFunDic[_view])
         {
            _cancelFunDic[_view] = null;
         }
         _view = null;
      }
      
      private function __onResponse(event:FrameEvent) : void
      {
         var model:* = null;
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               if(_cancelFunDic[_view] != null)
               {
                  _cancelFunDic[_view]();
               }
               break;
            case 2:
            case 3:
            case 4:
               if(!(_modelDic[_view] as TryonModel).selectedItem)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.tryonSystem.tryon"));
                  return;
               }
               if(_sumbmintFunDic[_view] != null)
               {
                  _sumbmintFunDic[_view]((_modelDic[_view] as TryonModel).selectedItem);
                  break;
               }
               break;
         }
         if(_modelDic[_view])
         {
            model = _modelDic[_view];
            model.dispose();
            model = null;
            delete _modelDic[_view];
         }
         if(_view)
         {
            _view.removeEventListener("response",__onResponse);
         }
         if(_view)
         {
            _view.removeEventListener("removedFromStage",__onRemoved);
         }
         if(_view)
         {
            _view.dispose();
         }
         if(_sumbmintFunDic[_view])
         {
            _sumbmintFunDic[_view] = null;
            delete _sumbmintFunDic[_view];
         }
         if(_cancelFunDic[_view])
         {
            _cancelFunDic[_view] = null;
            delete _cancelFunDic[_view];
         }
         _view = null;
      }
   }
}
