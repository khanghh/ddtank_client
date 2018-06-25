package floatParade.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import floatParade.FloatParadeManager;
   import floatParade.components.FloatParadeNameCell;
   import floatParade.data.FloatParadePlayerInfo;
   
   public class FloatParadeMissileFrame extends Frame
   {
       
      
      private var _labelBg:Bitmap;
      
      private var _labelTxt:FilterFrameText;
      
      private var _listBg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _submitBtn:TextButton;
      
      private var _list:Array;
      
      private var _playerList:Vector.<FloatParadePlayerInfo>;
      
      private var _threeBtnView:FloatParadeThreeBtnView;
      
      public function FloatParadeMissileFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         escEnable = true;
         enterEnable = true;
         _labelBg = ComponentFactory.Instance.creat("floatParade.missile.labelBg");
         addToContent(_labelBg);
         _listBg = ComponentFactory.Instance.creat("floatParade.missile.listBg");
         addToContent(_listBg);
         titleText = LanguageMgr.GetTranslation("floatParade.select");
         _labelTxt = ComponentFactory.Instance.creatComponentByStylename("floatParade.missileFrame.labelTxt");
         _labelTxt.text = LanguageMgr.GetTranslation("floatParade.selectTarget");
         addToContent(_labelTxt);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("floatParade.missileFrame.vbox");
         addToContent(_vbox);
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("ddtcore.quickEnter");
         PositionUtils.setPos(_submitBtn,"floatParade.missileFrame.btnPos");
         _submitBtn.text = LanguageMgr.GetTranslation("floatParade.sendMissile");
         addToContent(_submitBtn);
         setList();
      }
      
      private function setList() : void
      {
         var i:int = 0;
         var info:* = null;
         var cell:* = null;
         _playerList = FloatParadeManager.instance.playerList;
         _list = [];
         for(i = 0; i <= _playerList.length - 1; )
         {
            info = _playerList[i] as FloatParadePlayerInfo;
            if(!info.isSelf)
            {
               cell = new FloatParadeNameCell(i);
               cell.setData(info.name,info.level);
               cell.addEventListener("click",__cellClick);
               cell.buttonMode = true;
               _vbox.addChild(cell);
               _list.push(cell);
            }
            i++;
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_response);
         _submitBtn.addEventListener("click",__submitBtnClick);
      }
      
      protected function __cellClick(event:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var cell in _list)
         {
            cell.selected = false;
         }
         (event.currentTarget as FloatParadeNameCell).selected = true;
      }
      
      protected function __submitBtnClick(event:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list;
         for each(var cell in _list)
         {
            if(cell.selected == true)
            {
               _threeBtnView.targetId = _playerList[cell.index].id;
               _threeBtnView.targetZone = _playerList[cell.index].zoneId;
               _threeBtnView.useSkill();
            }
         }
         dispose();
      }
      
      public function setThreeBtnView(view:FloatParadeThreeBtnView) : void
      {
         _threeBtnView = view;
      }
      
      protected function _response(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         _submitBtn.removeEventListener("click",__submitBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_labelBg);
         _labelBg = null;
         ObjectUtils.disposeObject(_labelTxt);
         _labelTxt = null;
         ObjectUtils.disposeObject(_listBg);
         _listBg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_submitBtn);
         _submitBtn = null;
         super.dispose();
      }
   }
}
