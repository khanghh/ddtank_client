package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hall.event.NewHallEvent;
   import petsBag.data.PetsFormData;
   import petsBag.event.PetItemEvent;
   import road7th.comm.PackageIn;
   
   public class PetsFormView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _shiner:Bitmap;
      
      private var _lifeGuard:FilterFrameText;
      
      private var _absorbHurt:FilterFrameText;
      
      private var _prePageBtn:SimpleBitmapButton;
      
      private var _nextPageBtn:SimpleBitmapButton;
      
      private var _currentPageInput:Scale9CornerImage;
      
      private var _currentPage:FilterFrameText;
      
      private var _page:int = 1;
      
      private var _countPage:int = 1;
      
      private var _petsVec:Vector.<PetsFormPetsItem>;
      
      public function PetsFormView()
      {
         super();
         initData();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendPetFormInfo();
      }
      
      private function initData() : void
      {
         _petsVec = new Vector.<PetsFormPetsItem>();
         _countPage = Math.ceil(PetsAdvancedManager.Instance.formDataList.length / 6);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("petsBag.form.bg");
         addChild(_bg);
         _lifeGuard = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.lifeGuardText");
         addChild(_lifeGuard);
         _absorbHurt = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.lifeGuardText");
         PositionUtils.setPos(_absorbHurt,"petsBag.form.absorbHurtPos");
         addChild(_absorbHurt);
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.prePageBtn");
         addChild(_prePageBtn);
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.nextPageBtn");
         addChild(_nextPageBtn);
         _currentPageInput = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.currentPageInput");
         addChild(_currentPageInput);
         _currentPage = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.currentPage");
         _currentPage.text = _page + "/" + _countPage;
         addChild(_currentPage);
      }
      
      private function creatPetsView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = PetsAdvancedManager.Instance.formDataList;
         for each(var _loc2_ in PetsAdvancedManager.Instance.formDataList)
         {
            if(_loc2_.TemplateID == PlayerManager.Instance.Self.PetsID)
            {
               _loc2_.ShowBtn = 2;
               break;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.PetsFormPetsItem");
            if(_loc4_ < 3)
            {
               _loc1_.x = 34 + 180 * _loc4_;
               _loc1_.y = 95;
            }
            else
            {
               _loc1_.x = 34 + 180 * (_loc4_ - 3);
               _loc1_.y = 243;
            }
            _loc3_ = null;
            if(_loc4_ < PetsAdvancedManager.Instance.formDataList.length)
            {
               _loc3_ = PetsAdvancedManager.Instance.formDataList[_loc4_];
            }
            _loc1_.setInfo(_loc4_,_loc3_);
            _loc1_.addEventListener("itemclick",__onClickPetsItem);
            addChild(_loc1_);
            _petsVec.push(_loc1_);
            _loc4_++;
         }
         _shiner = ComponentFactory.Instance.creat("petsBag.form.clickPets");
         setShinerPos(0);
         addChild(_shiner);
         setItemInfo();
      }
      
      protected function __onClickPetsItem(param1:PetItemEvent) : void
      {
         var _loc2_:int = param1.data.id;
         setShinerPos(_loc2_);
      }
      
      private function setShinerPos(param1:int) : void
      {
         _shiner.x = _petsVec[param1].x - 4;
         _shiner.y = _petsVec[param1].y - 4;
      }
      
      private function setItemInfo() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < PetsAdvancedManager.Instance.formDataList.length)
         {
            _loc1_ = PetsAdvancedManager.Instance.formDataList[_loc4_];
            if(_loc1_ && _loc1_.State == 1)
            {
               _loc2_ = _loc2_ + _loc1_.HeathUp;
               _loc3_ = _loc3_ + _loc1_.DamageReduce;
            }
            _loc4_++;
         }
         _lifeGuard.text = LanguageMgr.GetTranslation("petsBag.form.petsListGuardTxt",_loc2_);
         _absorbHurt.text = LanguageMgr.GetTranslation("petsBag.form.petsabsorbHurtTxt",_loc3_);
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,24),__onGetPetsFormInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,25),__onPetsFollowOrCall);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,32),__onPetsWake);
      }
      
      protected function __onPrePageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_page > 1)
         {
            _page = Number(_page) - 1;
         }
         else
         {
            _page = _countPage;
         }
         _currentPage.text = _page + "/" + _countPage;
         setPageInfo();
      }
      
      protected function __onNextPageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(6 * _page < PetsAdvancedManager.Instance.formDataList.length)
         {
            _page = Number(_page) + 1;
         }
         else
         {
            _page = 1;
         }
         _currentPage.text = _page + "/" + _countPage;
         setPageInfo();
      }
      
      private function setPageInfo() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _petsVec.length)
         {
            _loc1_ = 6 * (_page - 1) + _loc3_;
            _loc2_ = null;
            if(_loc1_ < PetsAdvancedManager.Instance.formDataList.length)
            {
               _loc2_ = PetsAdvancedManager.Instance.formDataList[_loc1_];
            }
            _petsVec[_loc3_].setInfo(_loc3_,_loc2_);
            _loc3_++;
         }
      }
      
      protected function __onGetPetsFormInfo(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc5_.readInt();
            _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
            PetsAdvancedManager.Instance.formDataList[_loc2_].State = 1;
            PetsAdvancedManager.Instance.formDataList[_loc2_].ShowBtn = 1;
            PetsAdvancedManager.Instance.formDataList[_loc2_].valid = null;
            _loc7_++;
         }
         _loc3_ = _loc5_.readInt();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc5_.readInt();
            _loc4_ = _loc5_.readDate();
            if(_loc4_.getTime() < TimeManager.Instance.Now().getTime())
            {
               _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
               PetsAdvancedManager.Instance.formDataList[_loc2_].State = 0;
               PetsAdvancedManager.Instance.formDataList[_loc2_].ShowBtn = 3;
               PetsAdvancedManager.Instance.formDataList[_loc2_].valid = null;
            }
            else
            {
               _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
               PetsAdvancedManager.Instance.formDataList[_loc2_].State = 1;
               PetsAdvancedManager.Instance.formDataList[_loc2_].ShowBtn = 1;
               PetsAdvancedManager.Instance.formDataList[_loc2_].valid = _loc4_;
            }
            _loc7_++;
         }
         creatPetsView();
      }
      
      protected function __onPetsWake(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc6_:int = _loc4_.readInt();
         var _loc5_:Boolean = _loc4_.readBoolean();
         var _loc3_:Date = null;
         if(_loc5_)
         {
            _loc3_ = _loc4_.readDate();
         }
         var _loc2_:int = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc6_);
         PetsAdvancedManager.Instance.formDataList[_loc2_].State = 1;
         PetsAdvancedManager.Instance.formDataList[_loc2_].valid = _loc3_;
         resetItemInfo(_loc6_,1,_loc2_);
         _loc7_ = 0;
         while(_loc7_ < _petsVec.length)
         {
            if(_petsVec[_loc7_].info)
            {
               if(_petsVec[_loc7_].info.TemplateID == _loc6_)
               {
                  _petsVec[_loc7_].addPetBitmap(PetsAdvancedManager.Instance.formDataList[_loc2_].Appearance);
                  break;
               }
            }
            _loc7_++;
         }
      }
      
      protected function __onPetsFollowOrCall(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc4_.readBoolean();
         var _loc5_:int = _loc4_.readInt();
         if(_loc5_ != -1)
         {
            _loc2_ = PetsAdvancedManager.Instance.getFormDataIndexByTempId(_loc5_);
            resetItemInfo(_loc5_,!!_loc3_?2:1,_loc2_);
            PlayerManager.Instance.Self.PetsID = !!_loc3_?_loc5_:-1;
            PlayerManager.Instance.dispatchEvent(new NewHallEvent("showPets",[_loc3_,PetsAdvancedManager.Instance.formDataList[_loc2_].Resource]));
            if(_loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("petsBag.form.petsFollowStateTxt"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("petsBag.form.petsCallBackTxt"));
            }
         }
      }
      
      private function resetItemInfo(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = PetsAdvancedManager.Instance.formDataList;
         for each(var _loc4_ in PetsAdvancedManager.Instance.formDataList)
         {
            if(_loc4_.ShowBtn == 2)
            {
               _loc4_.ShowBtn = 1;
               break;
            }
         }
         setItemInfo();
         PetsAdvancedManager.Instance.formDataList[param3].ShowBtn = param2;
         _loc5_ = 0;
         while(_loc5_ < _petsVec.length)
         {
            if(_petsVec[_loc5_].info)
            {
               if(_petsVec[_loc5_].info.TemplateID == param1)
               {
                  _petsVec[_loc5_].setInfo(_loc5_,PetsAdvancedManager.Instance.formDataList[param3]);
               }
               else if(_petsVec[_loc5_].showBtn == 2)
               {
                  _petsVec[_loc5_].showBtn = 1;
               }
            }
            _loc5_++;
         }
      }
      
      private function removeEvent() : void
      {
         _prePageBtn.removeEventListener("click",__onPrePageClick);
         _nextPageBtn.removeEventListener("click",__onNextPageClick);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,24),__onGetPetsFormInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,25),__onPetsFollowOrCall);
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,32),__onPetsWake);
      }
      
      private function deletePets() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _petsVec.length)
         {
            if(_petsVec[_loc1_])
            {
               _petsVec[_loc1_].removeEventListener("itemclick",__onClickPetsItem);
               _petsVec[_loc1_].dispose();
               _petsVec[_loc1_] = null;
            }
            _loc1_++;
         }
         _petsVec.length = 0;
         _petsVec = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         deletePets();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         if(_lifeGuard)
         {
            _lifeGuard.dispose();
            _lifeGuard = null;
         }
         if(_absorbHurt)
         {
            _absorbHurt.dispose();
            _absorbHurt = null;
         }
         if(_prePageBtn)
         {
            _prePageBtn.dispose();
            _prePageBtn = null;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.dispose();
            _nextPageBtn = null;
         }
         if(_currentPageInput)
         {
            _currentPageInput.dispose();
            _currentPageInput = null;
         }
         if(_currentPage)
         {
            _currentPage.dispose();
            _currentPage = null;
         }
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
