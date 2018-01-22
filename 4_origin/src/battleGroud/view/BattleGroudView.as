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
      
      public function setTxt(param1:BattleUpdateData) : void
      {
         _txt2.text = String(param1.totalPrestige);
         _txt3.text = param1.addDayPrestge.toString();
         _txt1.text = String(param1.rankings);
         _txt5.text = String(param1.weekPrestige);
         setMilitary(param1.totalPrestige);
      }
      
      private function setMilitary(param1:int) : void
      {
         var _loc3_:BatlleData = BattleGroudControl.Instance.getBattleDataByPrestige(param1);
         var _loc2_:BatlleData = BattleGroudControl.Instance.getBattleDataByLevel(_loc3_.Level + 1);
         _txt4.text = _loc3_.Name;
         if(_loc2_.Prestige)
         {
            _miliContent.tipData = LanguageMgr.GetTranslation("ddt.battleGroud.updataLeavl",_loc2_.Prestige - param1);
         }
         else
         {
            _miliContent.tipStyle = null;
            ShowTipManager.Instance.removeTip(_miliContent);
         }
         creatIcon(_MiliIconList[_loc3_.Level]);
      }
      
      private function creatIcon(param1:String) : void
      {
         if(_miliIcon)
         {
            ObjectUtils.disposeObject(_miliIcon);
            _miliIcon = null;
         }
         _miliIcon = ComponentFactory.Instance.creat(param1);
         _miliIcon.x = _goodBack.x + (_goodBack.width - _miliIcon.width) / 2;
         _miliIcon.y = _goodBack.y + (_goodBack.height - _miliIcon.height) / 2;
         addToContent(_miliIcon);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _battleSkillBtn.addEventListener("click",skillBtnClick_Handler);
      }
      
      private function skillBtnClick_Handler(param1:MouseEvent) : void
      {
         onResponse(4);
         SoundManager.instance.play("008");
         BattleSkillManager.instance.show();
      }
      
      private function initRewardList() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.hBox");
         addToContent(_hBox1);
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.hBox");
         PositionUtils.setPos(_hBox2,"battleGroud.hBox2Pos");
         addToContent(_hBox2);
         _hBox3 = ComponentFactory.Instance.creatComponentByStylename("battleGroud.battleGroudView.hBox");
         PositionUtils.setPos(_hBox3,"battleGroud.hBox3Pos");
         addToContent(_hBox3);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,53,53);
         _loc1_.graphics.endFill();
         var _loc5_:Array = BattleGroudControl.Instance.awardDataList;
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc3_ = this["_hBox" + (int(_loc4_ / 4 + 1))] as HBox;
            _loc2_ = new BagCell(_loc4_,BattleGroudControl.Instance.awardDataList[_loc4_],true,_loc1_);
            _loc2_.refreshTbxPos();
            _loc3_.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
