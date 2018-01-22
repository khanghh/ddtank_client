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
      
      public function getModelByView(param1:Frame) : TryonModel
      {
         _view = param1;
         return _modelDic[param1];
      }
      
      public function get view() : Frame
      {
         return _view;
      }
      
      public function show(param1:Array, param2:Function = null, param3:Function = null) : void
      {
         if(_view)
         {
            return;
         }
         var _loc5_:TryonModel = new TryonModel(param1);
         var _loc4_:* = param2;
         var _loc6_:* = param3;
         if(EquipType.isAvatar(InventoryItemInfo(param1[0]).CategoryID))
         {
            _view = ComponentFactory.Instance.creatComponentByStylename("tryonSystem.tryonFrame") as TryonPanelFrame;
            _modelDic[_view] = _loc5_;
            TryonPanelFrame(_view).controller = this;
         }
         else
         {
            _view = ComponentFactory.Instance.creatComponentByStylename("tryonSystem.ChoosePanelFrame") as ChooseFrame;
            _modelDic[_view] = _loc5_;
            ChooseFrame(_view).controller = this;
         }
         if(_loc4_ != null)
         {
            _sumbmintFunDic[_view] = _loc4_;
         }
         if(_loc6_ != null)
         {
            _cancelFunDic[_view] = _loc6_;
         }
         _view.addEventListener("response",__onResponse);
         _view.addEventListener("removedFromStage",__onRemoved);
         LayerManager.Instance.addToLayer(_view,3,true,1,true);
      }
      
      private function __onRemoved(param1:Event) : void
      {
         var _loc2_:* = null;
         if(_modelDic[_view])
         {
            _loc2_ = _modelDic[_view];
            _loc2_.dispose();
            _loc2_ = null;
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
      
      private function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
            _loc2_ = _modelDic[_view];
            _loc2_.dispose();
            _loc2_ = null;
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
