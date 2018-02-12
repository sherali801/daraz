<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../layouts/admin/navbarHeader.jsp" />
<c:import url="../layouts/admin/index/searchbar.jsp" />
<c:import url="../layouts/admin/navbarFooter.jsp" />

<c:set var="id" value="${ product.id }" />
<c:set var="productName" value="${ product.productName }" />
<c:set var="imageURL" value="${ product.imageURL }" />
<c:set var="price" value="${ product.price }" />
<c:set var="quantity" value="${ product.quantity }" />
<c:set var="categoryId" value="${ product.categoryId }" />
<c:set var="manufacturerId" value="${ product.manufacturerId }" />
<c:set var="visibility" value="${ product.visibility }" />
<c:set var="description" value="${ product.description }" />

<c:if test="${ not empty editProductStatus }">
    <c:choose>
        <c:when test='${ editProductStatus eq "success" }'>
            <div class="alert alert-success offset-4 col-4">Product has been updated.</div>
        </c:when>
        <c:when test='${ editProductStatus eq "failure" }'>
            <div class="alert alert-danger offset-4 col-4">Product was not updated.</div>
        </c:when>
    </c:choose>
</c:if>

<form action="/sheralibaba/admin/edit/product?id=${ id }" method="post">
    <fieldset class="form-group">
        <legend class="text-center text-success">Edit Product</legend>
        <div class="form-group row">
            <label class="form-control-label col-4 col-form-label text-right" for="productName">Product Name</label>
            <div class="col-4">
                <input class="form-control" type="text" name="productName" value="${ productName }" id="productName" placeholder="Product Name" aria-describedby="productNameHelp" maxlength="25" required autofocus>
                <small id="productNameHelp" class="form-text text-muted">At max 25 character long.</small>
            </div>
        </div>
        <div class="form-group row">
            <label class="form-control-label col-4 col-form-label text-right" for="imageURL">Image URL</label>
            <div class="col-4">
                <input class="form-control" type="url" name="imageURL" value="${ imageURL }" id="imageURL" placeholder="Image URL" pattern="^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$" required>
            </div>
        </div>
        <div class="form-group row">
            <label for="price" class="form-control-label col-4 col-form-label text-right">Price</label>
            <div class="col-4">
                <input class="form-control" type="number" step="any" name="price" value="${ price }" id="price" placeholder="Price" min="0.1" required>
            </div>
        </div>
        <div class="form-group row">
            <label for="quantity" class="form-control-label col-4 col-form-label text-right">Quantity</label>
            <div class="col-4">
                <input class="form-control" type="number" name="quantity" value="${ quantity }" id="quantity" placeholder="Quantity" min="1" required>
            </div>
        </div>
        <div class="form-group row">
            <label for="categories" class="form-control-label col-4 col-form-label text-right">Category</label>
            <div class="col-4">
                <select class="form-control" name="categoryId" id="categories" required>
                    <c:forEach items="${ categories }" var="category">
                        <option value="${ category.id }" <c:if test="${ categoryId eq category.id }">selected</c:if>>${ category.categoryName }</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="manufacturers" class="form-control-label col-4 col-form-label text-right">Manufacturer</label>
            <div class="col-4">
                <select class="form-control" name="manufacturerId" id="manufacturers" required>
                    <c:forEach items="${ manufacturers }" var="manufacturer">
                        <option value="${ manufacturer.id }" <c:if test="${ manufacturerId eq manufacturer.id }">selected</c:if>>${ manufacturer.manufacturerName }</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="description" class="form-control-label col-4 col-form-label text-right">Visibility</label>
            <div class="col-4">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="visibility" id="visibilityYes" value="yes" <c:if test='${ visibility eq 1 }'>checked</c:if>>
                    <label class="form-check-label" for="visibilityYes">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="visibility" id="visibilityNo" value="no" <c:if test='${ visibility eq 0 }'>checked</c:if>>
                    <label class="form-check-label" for="visibilityNo">No</label>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label for="description" class="form-control-label col-4 col-form-label text-right">Description</label>
            <div class="col-4">
                <textarea name="description" class="form-control" id="description" rows="3" placeholder="Product Description" aria-describedby="productDescriptionHelp" maxlength="255" required>${ description }</textarea>
                <small id="productDescriptionHelp" class="form-text text-muted">At max 255 character long.</small>
            </div>
        </div>
        <div class="form-group row">
            <div class="offset-sm-4 col-4">
                <input class="btn btn-block btn-outline-success" type="submit" name="submit" value="Edit Product">
            </div>
        </div>
    </fieldset>
</form>

<c:import url="../layouts/admin/footer.jsp" />