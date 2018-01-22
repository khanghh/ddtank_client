package vip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class RechargeAlertTxt extends Sprite implements Disposeable
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _title:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      public function RechargeAlertTxt()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creat("VipRechargeLV.titleTxt");
         addChild(_title);
         _content = ComponentFactory.Instance.creat("VipRechargeLV.contentTxt");
         addChild(_content);
      }
      
      public function set AlertContent(param1:int) : void
      {
         _title.text = getAlertTitle(param1);
         _content.text = getAlertTxt(param1);
      }
      
      private function getAlertTxt(param1:int) : String
      {
         var _loc2_:String = "";
         switch(int(param1) - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               _loc2_ = _loc2_ + ("1、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1Param0")) + "\n");
               _loc2_ = _loc2_ + ("2、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2Param")) + "\n");
               _loc2_ = _loc2_ + ("3、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3Param")) + "\n");
               _loc2_ = _loc2_ + ("4、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4Param0")) + "\n");
               _loc2_ = _loc2_ + ("5、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5Param0")) + "\n");
               _loc2_ = _loc2_ + ("6、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent8") + "\n");
               _loc2_ = _loc2_ + ("7、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent9") + "\n");
               _loc2_ = _loc2_ + ("8、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent10",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent10Param0")) + "\n");
               _loc2_ = _loc2_ + ("9、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent11",";") + "\n");
               _loc2_ = _loc2_ + ("10、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent12",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent12Param0"),LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent12Param2")) + "\n");
               _loc2_ = _loc2_ + ("11、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.gainHotSpringBathrobe") + "\n");
               _loc2_ = _loc2_ + "            \n";
               break;
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               _loc2_ = _loc2_ + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent13") + "\n");
               _loc2_ = _loc2_ + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent14") + "\n");
               _loc2_ = _loc2_ + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent15") + "\n");
               _loc2_ = _loc2_ + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent16") + "\n");
               _loc2_ = _loc2_ + (LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent17") + "\n");
               _loc2_ = _loc2_ + ("6、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent1Param1")) + "\n");
               _loc2_ = _loc2_ + ("7、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent4Param1")) + "\n");
               _loc2_ = _loc2_ + ("8、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent3Param")) + "\n");
               _loc2_ = _loc2_ + ("9、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent2Param")) + "\n");
               _loc2_ = _loc2_ + ("10、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent8") + "\n");
               _loc2_ = _loc2_ + ("11、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5",LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent5Param1")) + "\n");
               _loc2_ = _loc2_ + ("12、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent11",";") + "\n");
               _loc2_ = _loc2_ + ("13、" + LanguageMgr.GetTranslation("tank.vip.rechargeAlertContent9") + "\n");
               _loc2_ = _loc2_ + ("14、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.gainHotSpringBathrobe") + "\n");
               _loc2_ = _loc2_ + ("15、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.FireworksWeekPacks") + "\n");
               _loc2_ = _loc2_ + ("16、" + LanguageMgr.GetTranslation("ddt.vip.PrivilegeViewItem.ExclusiveTitleAndClothing") + "\n");
               _loc2_ = _loc2_ + "            \n";
         }
         return _loc2_;
      }
      
      private function getAlertTitle(param1:int) : String
      {
         var _loc2_:String = "";
         switch(int(param1) - 1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
               _loc2_ = LanguageMgr.GetTranslation("tank.vip.rechargeAlertTitle",6);
               break;
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               _loc2_ = LanguageMgr.GetTranslation("tank.vip.rechargeAlertEndTitle",15);
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
      }
   }
}
