package ddt.view.academyCommon.myAcademy
{
   import academy.AcademyManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.academyCommon.myAcademy.myAcademyItem.MyAcademyClassmateItem;
   import ddt.view.academyCommon.myAcademy.myAcademyItem.MyAcademyMasterItem;
   
   public class MyAcademyApprenticeFrame extends MyAcademyMasterFrame implements Disposeable
   {
       
      
      private var _masterItem:MyAcademyMasterItem;
      
      private var _classmateItem:MyAcademyClassmateItem;
      
      private var _classmateItemII:MyAcademyClassmateItem;
      
      private var _masterInfo:PlayerInfo;
      
      private var _ApprenticeInfos:Vector.<PlayerInfo>;
      
      public function MyAcademyApprenticeFrame(){super();}
      
      override public function show() : void{}
      
      override protected function initContent() : void{}
      
      override protected function initItem() : void{}
      
      override protected function initEvent() : void{}
      
      override protected function updateItem() : void{}
      
      private function sliceInfo() : void{}
      
      override protected function clearItem() : void{}
   }
}
