package battleGroud.view
{
   import bagAndInfo.cell.BagCell;
   import battleGroud.BattleGroudControl;
   import battleGroud.data.BatlleData;
   import battleGroud.data.BattleUpdateData;
   import battleSkill.BattleSkillManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BattleGroudView extends BaseAlerFrame
   {
       
      
      private var _back:Bitmap;
      
      private var _goodBack:Bitmap;
      
      private var _battleSkillBtn:BaseButton;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _txt5:FilterFrameText;
      
      private var _txt7:FilterFrameText;
      
      private var _descripMc:MovieClip;
      
      private var _list:VBox;
      
      private var _miliContent:Component;
      
      private var _miliIcon:Bitmap;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _hBox1:HBox;
      
      private var _hBox2:HBox;
      
      private var _hBox3:HBox;
      
      private var _MiliIconList:Array;
      
      private var _scrollPanel:ListPanel;
      
      private var content:Sprite;
      
      public function BattleGroudView()
      {
         _MiliIconList = ["","battle.junxian.xinbingBig","battle.junxian.xiashiBig","battle.junxian.zhongshiBig","battle.junxian.shangshiBig","battle.junxian.shaoweiBig","battle.junxian.zhongweiBig","battle.junxian.shangweiBig","battle.junxian.shaoxiaoBig","battle.junxian.zhongxiaoBig","battle.junxian.shangxiaoBig","battle.junxian.shaojiangBig","battle.junxian.zhongjiangBig","battle.junxian.shangjiangBig","battle.junxian.cishuaiBig","battle.junxian.yuanshuaiBig","battle.junxian.dayuanshuaiBig"];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         info = new AlertInfo(LanguageMgr.GetTranslation("ddt.battleGroud"));
         _info.showSubmit = false;
         _info.showCancel = false;
         _info.moveEnable = false;
         _back = ComponentFactory.Instance.creat("battle.ground");
         addToContent(_back);
         _goodBack = ComponentFactory.Instance.creat("battle.goodsContent");
         addToContent(_goodBack);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.txt1");
         addToContent(_txt1);
         _txt7 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.txt5");
         _txt7.text = LanguageMgr.GetTranslation("ddt.battleGroud.tips");
         addToContent(_txt7);
         _battleSkillBtn = ComponentFactory.Instance.creatComponentByStylename("battle.gotoSkill");
         addToContent(_battleSkillBtn);
         _miliContent = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.comp");
         _miliContent.graphics.beginFill(0);
         _miliContent.graphics.drawRect(0,0,100,20);
         _miliContent.graphics.endFill();
         _miliContent.alpha = 0;
         addToContent(_miliContent);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.txt2");
         addToContent(_txt2);
         _txt3 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.txt3");
         addToContent(_txt3);
         _txt4 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.txt4");
         addToContent(_txt4);
         _txt5 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.txt3");
         PositionUtils.setPos(_txt5,"battleGroud.txt5Pos");
         addToContent(_txt5);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("battleGround.scrollPanel");
         _scrollPanel.vectorListModel.clear();
         _scrollPanel.vectorListModel.appendAll([{}]);
         _scrollPanel.list.updateListView();
         content = new Sprite();
         content.addChild(_scrollPanel);
         _scrollPanel.x = 37;
         _scrollPanel.y = 71;
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),content,404,484) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,"battleGroud.helpBtnPos");
         initRewardList();
         setTxt(BattleGroudControl.Instance.orderdata);
         SocketManager.Instance.out.battleGroundUpdata(2);
         SocketManager.Instance.out.battleGroundUpdata(1);
      }
      
      public function setTxt(data:BattleUpdateData) : void
      {
         _txt2.text = String(data.totalPrestige);
         _txt3.text = data.addDayPrestge.toString();
         _txt1.text = String(data.rankings);
         _txt5.text = String(data.weekPrestige);
         setMilitary(data.totalPrestige);
      }
      
      private function setMilitary(num:int) : void
      {
         var tmpData:BatlleData = BattleGroudControl.Instance.getBattleDataByPrestige(num);
         var nextData:BatlleData = BattleGroudControl.Instance.getBattleDataByLevel(tmpData.Level + 1);
         _txt4.text = tmpData.Name;
         if(nextData.Prestige)
         {
            _miliContent.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.updataLeavl",nextData.Prestige - num);
         }
         else
         {
            _miliContent.tipStyle = null;
            ShowTipManager.Instance.removeTip(_miliContent);
         }
         creatIcon(_MiliIconList[tmpData.Level]);
      }
      
      private function creatIcon(url:String) : void
      {
         if(_miliIcon)
         {
            ObjectUtils.disposeObject(_miliIcon);
            _miliIcon = null;
         }
         _miliIcon = ComponentFactory.Instance.creat(url);
         _miliIcon.x = _goodBack.x + (_goodBack.width - _miliIcon.width) / 2;
         _miliIcon.y = _goodBack.y + (_goodBack.height - _miliIcon.height) / 2;
         addToContent(_miliIcon);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _battleSkillBtn.addEventListener("click",skillBtnClick_Handler);
      }
      
      private function skillBtnClick_Handler(evt:MouseEvent) : void
      {
         onResponse(4);
         SoundManager.instance.play("008");
         BattleSkillManager.instance.show();
      }
      
      private function initRewardList() : void
      {
         var hBox:* = null;
         var cell:* = null;
         var i:int = 0;
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.hBox");
         addToContent(_hBox1);
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.hBox");
         PositionUtils.setPos(_hBox2,"battleGroud.hBox2Pos");
         addToContent(_hBox2);
         _hBox3 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.hBox");
         PositionUtils.setPos(_hBox3,"battleGroud.hBox3Pos");
         addToContent(_hBox3);
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,53,53);
         sp.graphics.endFill();
         var array:Array = BattleGroudControl.Instance.awardDataList;
         for(i = 0; i < 12; )
         {
            hBox = this["_hBox" + (int(i / 4 + 1))] as HBox;
            cell = new BagCell(i,BattleGroudControl.Instance.awardDataList[i],true,sp);
            cell.refreshTbxPos();
            hBox.addChild(cell);
            i++;
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
            default:
            default:
            case 4:
         }
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         _info = null;
         if(!_container)
         {
            return;
         }
         if(_battleSkillBtn)
         {
            _battleSkillBtn.removeEventListener("click",skillBtnClick_Handler);
            ObjectUtils.disposeObject(_battleSkillBtn);
         }
         _battleSkillBtn = null;
         while(_container.numChildren)
         {
            ObjectUtils.disposeObject(_container.getChildAt(0));
         }
         super.dispose();
      }
   }
}
