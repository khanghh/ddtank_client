package signBuff.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import signBuff.SignBuffManager;
   
   public class PowerItem extends Sprite implements Disposeable
   {
       
      
      private var _powerTxt:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _getBtn:BaseButton;
      
      private var _hasGet:Bitmap;
      
      private var _index:int;
      
      private var _arr:Array;
      
      public function PowerItem(param1:Array, param2:int)
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         super();
         _arr = param1;
         _index = param2;
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("hall.PowerView.powerTxt");
         addChild(_powerTxt);
         _powerTxt.text = LanguageMgr.GetTranslation("ddt.hall.signBuff.power",changeNum(param1[0].Quality));
         _hbox = ComponentFactory.Instance.creatComponentByStylename("hall.powerView.hBox");
         addChild(_hbox);
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = new InventoryItemInfo();
            _loc5_.TemplateID = param1[_loc6_].TemplateID;
            _loc5_ = ItemManager.fill(_loc5_);
            _loc5_.IsBinds = param1[_loc6_].IsBind;
            _loc5_.ValidDate = param1[_loc6_].ValidDate;
            _loc5_.StrengthenLevel = param1[_loc6_].StrengthLevel;
            _loc5_.AttackCompose = param1[_loc6_].AttackCompose;
            _loc5_.DefendCompose = param1[_loc6_].DefendCompose;
            _loc5_.AgilityCompose = param1[_loc6_].AgilityCompose;
            _loc5_.LuckCompose = param1[_loc6_].LuckCompose;
            _loc5_.Count = param1[_loc6_].Count;
            _loc3_ = new BagCell(0,_loc5_,false);
            if(_loc5_.MaxCount == 1 && _loc5_.Count > _loc5_.MaxCount)
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
               _loc4_.text = String(_loc5_.Count);
               _loc4_.x = 34;
               _loc4_.y = 31;
               _loc3_.addChild(_loc4_);
            }
            _hbox.addChild(_loc3_);
            _loc6_++;
         }
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("hall.powerView.getBtn");
         addChild(_getBtn);
         _getBtn.addEventListener("click",clickHandler);
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.hall.signBuff.getIcon");
         addChild(_hasGet);
         var _loc7_:* = SignBuffManager.instance.fightPowerArr[_index];
         if(0 !== _loc7_)
         {
            if(1 !== _loc7_)
            {
               if(2 === _loc7_)
               {
                  _getBtn.visible = false;
               }
            }
            else
            {
               _hasGet.visible = false;
            }
         }
         else
         {
            _hasGet.visible = false;
            _getBtn.enable = false;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.getSignBuff(_arr[0].Quality);
         _hasGet.visible = true;
         _getBtn.visible = false;
      }
      
      private function changeNum(param1:int) : String
      {
         var _loc3_:Number = param1 * 10000;
         var _loc2_:String = "";
         if(_loc3_ > 999999999)
         {
            _loc2_ = String(_loc3_);
            _loc2_ = _loc2_.substring(0,_loc2_.length - 9) + "," + _loc2_.substring(_loc2_.length - 9,_loc2_.length - 6) + "," + _loc2_.substring(_loc2_.length - 6,_loc2_.length - 3) + "," + _loc2_.substring(_loc2_.length - 3,_loc2_.length);
         }
         else if(_loc3_ > 999999)
         {
            _loc2_ = String(_loc3_);
            _loc2_ = _loc2_.substring(0,_loc2_.length - 6) + "," + _loc2_.substring(_loc2_.length - 6,_loc2_.length - 3) + "," + _loc2_.substring(_loc2_.length - 3,_loc2_.length);
         }
         else if(_loc3_ > 999)
         {
            _loc2_ = String(_loc3_);
            _loc2_ = _loc2_.substring(0,_loc2_.length - 3) + "," + _loc2_.substring(_loc2_.length - 3,_loc2_.length);
         }
         else
         {
            _loc2_ = String(_loc3_);
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         _getBtn.removeEventListener("click",clickHandler);
         if(_powerTxt)
         {
            ObjectUtils.disposeObject(_powerTxt);
            _powerTxt = null;
         }
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
            _hbox = null;
         }
         if(_getBtn)
         {
            ObjectUtils.disposeObject(_getBtn);
            _getBtn = null;
         }
         if(_hasGet)
         {
            ObjectUtils.disposeObject(_hasGet);
            _hasGet = null;
         }
      }
   }
}
