package gradeBuy.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperHelpBtnCreate;
   import ddt.utils.Helpers;
   import gradeBuy.GradeBuyManager;
   import gradeBuy.ICountDown;
   
   public class GradeBuyItemsListView extends Frame implements ICountDown
   {
       
      
      private var _itemList:Vector.<GradeBuyItem>;
      
      private var _remainTimeDetailTxt:FilterFrameText;
      
      private var _remainTimeTxt:FilterFrameText;
      
      private var _info:ItemTemplateInfo;
      
      private var _data:Object;
      
      private var _detailString:String;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _helpBtnHelper:HelperHelpBtnCreate;
      
      public function GradeBuyItemsListView()
      {
         super();
         ShowTipManager.Instance.tempChangeTipContainer();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         var item:* = null;
         super.init();
         escEnable = true;
         _itemList = new Vector.<GradeBuyItem>();
         for(i = 0; i < 3; )
         {
            item = new GradeBuyItem(i);
            item.x = 24 + i * 216;
            item.y = 55;
            addToContent(item);
            _itemList.push(item);
            i++;
         }
         _detailString = LanguageMgr.GetTranslation("ddt.shop.gradeBuy.detail");
         _remainTimeDetailTxt = ComponentFactory.Instance.creat("gradeBuy.ItemView.detailTxt");
         _remainTimeDetailTxt.text = _detailString;
         addToContent(_remainTimeDetailTxt);
         _remainTimeTxt = ComponentFactory.Instance.creat("gradeBuy.ItemView.timeRemainTxt");
         _remainTimeTxt.text = "00:00:00";
         addToContent(_remainTimeTxt);
         _helpBtnHelper = new HelperHelpBtnCreate();
         _helpBtnHelper.create(this,"ast.gb.help",null,"gradeBuy.helpBtn.pt",LanguageMgr.GetTranslation("tank.data.gradeBuy.box.help"));
         addEventListener("response",_response);
         addEventListener("gb_buy",onBuyClick);
      }
      
      protected function onBuyClick(e:CEvent) : void
      {
         ObjectUtils.disposeObject(this);
         GradeBuyManager.getInstance().requireBuy(e.data[0],e.data[1]);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      public function setData($info:ItemTemplateInfo, $data:Object) : void
      {
         var i:int = 0;
         var __info:* = null;
         _info = $info;
         _data = $data;
         titleText = _info.Name;
         for(i = 0; i < 3; )
         {
            __info = ItemManager.Instance.getTemplateById(int($info["Property" + (i + 2).toString()]));
            _itemList[i].update(_info,__info,$data["id" + i.toString()] != 0);
            i++;
         }
         GradeBuyManager.getInstance().register(this.name,this);
      }
      
      public function update() : void
      {
         if(_remainTimeTxt == null)
         {
            return;
         }
         var dateStop:Number = _data["date"];
         var time:Number = dateStop - TimeManager.Instance.Now().time;
         if(time <= 0)
         {
            _remainTimeTxt.text = "00:00:00";
            GradeBuyManager.getInstance().unRegister(this.name);
         }
         else
         {
            _remainTimeTxt.text = Helpers.getTimeString(time);
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         GradeBuyManager.getInstance().stopTimer();
         ShowTipManager.Instance.setup();
         super.dispose();
         removeEventListener("response",_response);
         GradeBuyManager.getInstance().unRegister(this.name);
         GradeBuyManager.getInstance().viewClosed();
         if(_itemList)
         {
            for(i = 0; i < 3; )
            {
               ObjectUtils.disposeObject(_itemList[i]);
               _itemList[i] = null;
               i++;
            }
            _itemList.length = 0;
            _itemList = null;
            if(_helpBtn)
            {
               ObjectUtils.disposeObject(_helpBtn);
               _helpBtn = null;
            }
         }
         if(_helpBtnHelper)
         {
            _helpBtnHelper.dispose();
            _helpBtnHelper = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _remainTimeTxt = null;
         _remainTimeDetailTxt = null;
      }
   }
}
