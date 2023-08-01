<!-- Content Area -->
<div class="content">
    <!-- Add your admin panel content here -->
    <form action="add_product.php" method="post">
        <div class="form-group" style="margin-bottom: 10px;">
            <label for="product_name">Product Name:</label>
            <input type="text" id="product_name" name="product_name" required>
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="product_description">Product Description:</label>
            <textarea id="product_description" name="product_description" required></textarea>
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="product_price">Product Price:</label>
            <input type="number" id="product_price" name="product_price" min="0.01" step="0.01" required>
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="category_id">Category ID:</label>
            <input type="number" id="category_id" name="category_id">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="brand">Brand:</label>
            <input type="text" id="brand" name="brand">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="weight">Weight:</label>
            <input type="number" id="weight" name="weight" step="0.01">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="color">Color:</label>
            <input type="text" id="color" name="color">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="material">Material:</label>
            <input type="text" id="material" name="material">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="stock_quantity">Stock Quantity:</label>
            <input type="number" id="stock_quantity" name="stock_quantity">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="is_available">Is Available:</label>
            <input type="checkbox" id="is_available" name="is_available" checked>
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <!-- You can use an appropriate date-time picker for the created_at field -->
            <label for="created_at">Created At:</label>
            <input type="datetime-local" id="created_at" name="created_at" value="<?= date('Y-m-d\TH:i'); ?>">
        </div>

        <div class="form-group" style="margin-bottom: 10px;">
            <label for="image_url">Image URL:</label>
            <input type="text" id="image_url" name="image_url">
        </div>

        <input type="submit" value="Add Product">
    </form>
</div>
