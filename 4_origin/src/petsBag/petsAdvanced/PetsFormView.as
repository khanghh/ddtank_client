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
         var i:int = 0;
         var petsItem:* = null;
         var info:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = PetsAdvancedManager.Instance.formDataList;
         for each(var tempInfo in PetsAdvancedManager.Instance.formDataList)
         {
            if(tempInfo.TemplateID == PlayerManager.Instance.Self.PetsID)
            {
               tempInfo.ShowBtn = 2;
               break;
            }
         }
         i = 0;
         while(i < 6)
         {
            petsItem = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.PetsFormPetsItem");
            if(i < 3)
            {
               petsItem.x = 34 + 180 * i;
               petsItem.y = 95;
            }
            else
            {
               petsItem.x = 34 + 180 * (i - 3);
               petsItem.y = 243;
            }
            info = null;
            if(i < PetsAdvancedManager.Instance.formDataList.length)
            {
               info = PetsAdvancedManager.Instance.formDataList[i];
            }
            petsItem.setInfo(i,info);
            petsItem.addEventListener("itemclick",__onClickPetsItem);
            addChild(petsItem);
            _petsVec.push(petsItem);
            i++;
         }
         _shiner = ComponentFactory.Instance.creat("petsBag.form.clickPets");
         setShinerPos(0);
         addChild(_shiner);
         setItemInfo();
      }
      
      protected function __onClickPetsItem(event:PetItemEvent) : void
      {
         var id:int = event.data.id;
         setShinerPos(id);
      }
      
      private function setShinerPos(id:int) : void
      {
         _shiner.x = _petsVec[id].x - 4;
         _shiner.y = _petsVec[id].y - 4;
      }
      
      private function setItemInfo() : void
      {
         var i:int = 0;
         var tempInfo:* = null;
         var healthNum:int = 0;
         var damageReduce:int = 0;
         for(i = 0; i < PetsAdvancedManager.Instance.formDataList.length; )
         {
            tempInfo = PetsAdvancedManager.Instance.formDataList[i];
            if(tempInfo && tempInfo.State == 1)
            {
               healthNum = healthNum + tempInfo.HeathUp;
               damageReduce = damageReduce + tempInfo.DamageReduce;
            }
            i++;
         }
         _lifeGuard.text = LanguageMgr.GetTranslation("petsBag.form.petsListGuardTxt",healthNum);
         _absorbHurt.text = LanguageMgr.GetTranslation("petsBag.form.petsabsorbHurtTxt",damageReduce);
      }
      
      private function initEvent() : void
      {
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,24),__onGetPetsFormInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,25),__onPetsFollowOrCall);
         SocketManager.Instance.addEventListener(PkgEvent.format(68,32),__onPetsWake);
      }
      
      protected function __onPrePageClick(event:MouseEvent) : void
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
      
      protected function __onNextPageClick(event:MouseEvent) : void
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
         var i:int = 0;
         var index:int = 0;
         var info:* = null;
         for(i = 0; i < _petsVec.length; )
         {
            index = 6 * (_page - 1) + i;
            info = null;
            if(index < PetsAdvancedManager.Instance.formDataList.length)
            {
               info = PetsAdvancedManager.Instance.formDataList[index];
            }
            _petsVec[i].setInfo(i,info);
            i++;
         }
      }
      
      protected function __onGetPetsFormInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var tempId:int = 0;
         var index:int = 0;
         var validDate:* = null;
         var pkg:PackageIn = event.pkg;
         var num:int = pkg.readInt();
         for(i = 0; i < num; )
         {
            tempId = pkg.readInt();
            index = PetsAdvancedManager.Instance.getFormDataIndexByTempId(tempId);
            PetsAdvancedManager.Instance.formDataList[index].State = 1;
            PetsAdvancedManager.Instance.formDataList[index].ShowBtn = 1;
            PetsAdvancedManager.Instance.formDataList[index].valid = null;
            i++;
         }
         num = pkg.readInt();
         for(i = 0; i < num; )
         {
            tempId = pkg.readInt();
            validDate = pkg.readDate();
            if(validDate.getTime() < TimeManager.Instance.Now().getTime())
            {
               index = PetsAdvancedManager.Instance.getFormDataIndexByTempId(tempId);
               PetsAdvancedManager.Instance.formDataList[index].State = 0;
               PetsAdvancedManager.Instance.formDataList[index].ShowBtn = 3;
               PetsAdvancedManager.Instance.formDataList[index].valid = null;
            }
            else
            {
               index = PetsAdvancedManager.Instance.getFormDataIndexByTempId(tempId);
               PetsAdvancedManager.Instance.formDataList[index].State = 1;
               PetsAdvancedManager.Instance.formDataList[index].ShowBtn = 1;
               PetsAdvancedManager.Instance.formDataList[index].valid = validDate;
            }
            i++;
         }
         creatPetsView();
      }
      
      protected function __onPetsWake(event:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var tempId:int = pkg.readInt();
         var isValid:Boolean = pkg.readBoolean();
         var validDate:Date = null;
         if(isValid)
         {
            validDate = pkg.readDate();
         }
         var index:int = PetsAdvancedManager.Instance.getFormDataIndexByTempId(tempId);
         PetsAdvancedManager.Instance.formDataList[index].State = 1;
         PetsAdvancedManager.Instance.formDataList[index].valid = validDate;
         resetItemInfo(tempId,1,index);
         for(i = 0; i < _petsVec.length; )
         {
            if(_petsVec[i].info)
            {
               if(_petsVec[i].info.TemplateID == tempId)
               {
                  _petsVec[i].addPetBitmap(PetsAdvancedManager.Instance.formDataList[index].Appearance);
                  break;
               }
            }
            i++;
         }
      }
      
      protected function __onPetsFollowOrCall(event:PkgEvent) : void
      {
         var index:int = 0;
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         var tempId:int = pkg.readInt();
         if(tempId != -1)
         {
            index = PetsAdvancedManager.Instance.getFormDataIndexByTempId(tempId);
            resetItemInfo(tempId,!!flag?2:1,index);
            PlayerManager.Instance.Self.PetsID = !!flag?tempId:-1;
            PlayerManager.Instance.dispatchEvent(new NewHallEvent("showPets",[flag,PetsAdvancedManager.Instance.formDataList[index].Resource]));
            if(flag)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("petsBag.form.petsFollowStateTxt"));
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("petsBag.form.petsCallBackTxt"));
            }
         }
      }
      
      private function resetItemInfo(tempId:int, showBtn:int, index:int) : void
      {
         var i:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = PetsAdvancedManager.Instance.formDataList;
         for each(var tempInfo in PetsAdvancedManager.Instance.formDataList)
         {
            if(tempInfo.ShowBtn == 2)
            {
               tempInfo.ShowBtn = 1;
               break;
            }
         }
         setItemInfo();
         PetsAdvancedManager.Instance.formDataList[index].ShowBtn = showBtn;
         for(i = 0; i < _petsVec.length; )
         {
            if(_petsVec[i].info)
            {
               if(_petsVec[i].info.TemplateID == tempId)
               {
                  _petsVec[i].setInfo(i,PetsAdvancedManager.Instance.formDataList[index]);
               }
               else if(_petsVec[i].showBtn == 2)
               {
                  _petsVec[i].showBtn = 1;
               }
            }
            i++;
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
         var i:int = 0;
         for(i = 0; i < _petsVec.length; )
         {
            if(_petsVec[i])
            {
               _petsVec[i].removeEventListener("itemclick",__onClickPetsItem);
               _petsVec[i].dispose();
               _petsVec[i] = null;
            }
            i++;
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
