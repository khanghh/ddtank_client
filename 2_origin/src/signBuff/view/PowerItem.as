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
      
      public function PowerItem(arr:Array, index:int)
      {
         var i:int = 0;
         var info:* = null;
         var _cell:* = null;
         var countTxt:* = null;
         super();
         _arr = arr;
         _index = index;
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("hall.PowerView.powerTxt");
         addChild(_powerTxt);
         _powerTxt.text = LanguageMgr.GetTranslation("ddt.hall.signBuff.power",changeNum(arr[0].Quality));
         _hbox = ComponentFactory.Instance.creatComponentByStylename("hall.powerView.hBox");
         addChild(_hbox);
         for(i = 0; i < arr.length; )
         {
            info = new InventoryItemInfo();
            info.TemplateID = arr[i].TemplateID;
            info = ItemManager.fill(info);
            info.IsBinds = arr[i].IsBind;
            info.ValidDate = arr[i].ValidDate;
            info.StrengthenLevel = arr[i].StrengthLevel;
            info.AttackCompose = arr[i].AttackCompose;
            info.DefendCompose = arr[i].DefendCompose;
            info.AgilityCompose = arr[i].AgilityCompose;
            info.LuckCompose = arr[i].LuckCompose;
            info.Count = arr[i].Count;
            _cell = new BagCell(0,info,false);
            if(info.MaxCount == 1 && info.Count > info.MaxCount)
            {
               countTxt = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
               countTxt.text = String(info.Count);
               countTxt.x = 34;
               countTxt.y = 31;
               _cell.addChild(countTxt);
            }
            _hbox.addChild(_cell);
            i++;
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
      
      private function clickHandler(e:MouseEvent) : void
      {
         SocketManager.Instance.out.getSignBuff(_arr[0].Quality);
         _hasGet.visible = true;
         _getBtn.visible = false;
      }
      
      private function changeNum(num:int) : String
      {
         var _num:Number = num * 10000;
         var str:String = "";
         if(_num > 999999999)
         {
            str = String(_num);
            str = str.substring(0,str.length - 9) + "," + str.substring(str.length - 9,str.length - 6) + "," + str.substring(str.length - 6,str.length - 3) + "," + str.substring(str.length - 3,str.length);
         }
         else if(_num > 999999)
         {
            str = String(_num);
            str = str.substring(0,str.length - 6) + "," + str.substring(str.length - 6,str.length - 3) + "," + str.substring(str.length - 3,str.length);
         }
         else if(_num > 999)
         {
            str = String(_num);
            str = str.substring(0,str.length - 3) + "," + str.substring(str.length - 3,str.length);
         }
         else
         {
            str = String(_num);
         }
         return str;
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
