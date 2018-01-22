package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import ringStation.model.BattleFieldListItemInfo;
   import road7th.comm.PackageIn;
   
   public class BattleFieldsView extends Frame
   {
      
      private static const BATTLEFILEDSNUM:int = 11;
       
      
      private var _bg:MutipleImage;
      
      private var _itemVec:Vector.<BattleFieldsItem>;
      
      public function BattleFieldsView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ringStation.view.battleFieldsView.titleInfo");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.battleField.bg");
         addToContent(_bg);
         initItemData();
         sendPkg();
      }
      
      private function initItemData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _itemVec = new Vector.<BattleFieldsItem>();
         var _loc3_:Point = PositionUtils.creatPoint("ringStation.view.battleField.itemPos");
         _loc2_ = 0;
         while(_loc2_ < 11)
         {
            _loc1_ = new BattleFieldsItem(_loc2_);
            _loc1_.x = _loc3_.x;
            _loc1_.y = _loc3_.y + _loc2_ * 34;
            addToContent(_loc1_);
            _itemVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendRingStationBattleField();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,4),__onUpdateNewBattleField);
      }
      
      protected function __onUpdateNewBattleField(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc6_:BattleFieldListItemInfo = new BattleFieldListItemInfo();
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:String = "";
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_.DareFlag = _loc4_.readBoolean();
            _loc6_.UserName = _loc4_.readUTF();
            _loc6_.SuccessFlag = _loc4_.readBoolean();
            _loc6_.Level = _loc4_.readInt();
            _itemVec[_loc5_].update(_loc6_);
            _loc5_++;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(404,4),__onUpdateNewBattleField);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         _loc1_ = 0;
         while(_loc1_ < _itemVec.length)
         {
            if(_itemVec[_loc1_])
            {
               ObjectUtils.disposeObject(_itemVec[_loc1_]);
               _itemVec[_loc1_] = null;
            }
            _loc1_++;
         }
         _itemVec.length = 0;
         _itemVec = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
